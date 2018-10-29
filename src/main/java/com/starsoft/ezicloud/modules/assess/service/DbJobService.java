/**
 * Copyright &copy; 2012-2014 <a href="http://www.stars-soft.com">EziCloud</a> All rights reserved.
 */
package com.starsoft.ezicloud.modules.assess.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.starsoft.ezicloud.common.persistence.Page;
import com.starsoft.ezicloud.common.service.CrudService;
import com.starsoft.ezicloud.common.utils.IdGen;
import com.starsoft.ezicloud.common.utils.StringUtils;
import com.starsoft.ezicloud.modules.assess.entity.DbEvaluatingTeam;
import com.starsoft.ezicloud.modules.assess.entity.DbEvaluatingTeamMember;
import com.starsoft.ezicloud.modules.assess.entity.DbJob;
import com.starsoft.ezicloud.modules.assess.entity.DbJobSelf;
import com.starsoft.ezicloud.modules.assess.entity.ReTeacherplan;
import com.starsoft.ezicloud.modules.sys.dao.UserDao;
import com.starsoft.ezicloud.modules.sys.entity.Role;
import com.starsoft.ezicloud.modules.sys.entity.User;
import com.starsoft.ezicloud.modules.sys.utils.UserUtils;
import com.starsoft.ezicloud.modules.assess.dao.DbEvaluatingTeamDao;
import com.starsoft.ezicloud.modules.assess.dao.DbJobDao;
import com.starsoft.ezicloud.modules.assess.dao.DbJobSelfDao;

/**
 * 任务创建Service
 * @author suxl
 * @version 2017-09-19
 */
@Service
@Transactional(readOnly = true)
public class DbJobService extends CrudService<DbJobDao, DbJob> {
	@Autowired
	private DbJobSelfDao dbJobSelfDao;
	@Autowired
	private ReTeacherplanService reTeacherplanService;
	
	@Autowired
	private UserDao userDao;

	public DbJob get(String id) {
		return super.get(id);
	}
	
	public List<DbJob> findList(DbJob dbJob) {
		return super.findList(dbJob);
	}
	
	public Page<DbJob> findPage(Page<DbJob> page, DbJob dbJob) {
		User user = UserUtils.getUser();
		
		if(!user.getId().equals("1")){
			dbJob.setDef4(user.getId());
		}
		
		return super.findPage(page, dbJob);
	}
	
	@Transactional(readOnly = false)
	public void save(DbJob dbJob) {
		String userid = dbJob.getEvaluationTarget().getId();
		String url = dbJob.getDef5();
		String coursechildid = dbJob.getDef3();
		super.save(dbJob);
		if(StringUtils.isNotBlank(url)&&StringUtils.isNotBlank(coursechildid)){
			ReTeacherplan	reTeacherplan   = new ReTeacherplan() ;
			reTeacherplan.setTeacherId(userid);
			reTeacherplan.setClassCourseChildId(coursechildid);
			reTeacherplan.setFileUrl(url);
			reTeacherplan.setUpdateDate(new Date());
			reTeacherplanService.save(reTeacherplan);
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(DbJob dbJob) {
		super.delete(dbJob);
		DbJobSelf dbJobSelf = new DbJobSelf();
		dbJobSelf.setJobId(dbJob);
		dbJobSelf.setDelFlag("1");
		//任务下的个人任务
		dbJobSelfDao.deleteById(dbJobSelf);
		
		
		
	}
	
}