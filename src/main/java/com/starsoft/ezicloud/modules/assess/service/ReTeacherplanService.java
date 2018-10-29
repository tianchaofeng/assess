/**
 * Copyright &copy; 2012-2014 <a href="http://www.stars-soft.com">EziCloud</a> All rights reserved.
 */
package com.starsoft.ezicloud.modules.assess.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.starsoft.ezicloud.common.persistence.Page;
import com.starsoft.ezicloud.common.service.CrudService;
import com.starsoft.ezicloud.modules.assess.dao.DbJobDao;
import com.starsoft.ezicloud.modules.assess.dao.ReTeacherplanDao;
import com.starsoft.ezicloud.modules.assess.entity.DbJob;
import com.starsoft.ezicloud.modules.assess.entity.ReTeacherplan;
import com.starsoft.ezicloud.modules.sys.entity.User;

/**
 * 教案Service
 * @author tcf
 * @version 2017-12-22
 */
@Service
@Transactional(readOnly = true)
public class ReTeacherplanService extends CrudService<ReTeacherplanDao, ReTeacherplan> {
	@Autowired
	private DbJobDao dbJobDao;
	
	public ReTeacherplan get(String id) {
		return super.get(id);
	}
	
	public List<ReTeacherplan> findList(ReTeacherplan reTeacherplan) {
		return super.findList(reTeacherplan);
	}
	
	public Page<ReTeacherplan> findPage(Page<ReTeacherplan> page, ReTeacherplan reTeacherplan) {
		return super.findPage(page, reTeacherplan);
	}
	
	@Transactional(readOnly = false)
	public void save(ReTeacherplan reTeacherplan) {
		super.save(reTeacherplan);
		DbJob job  = new DbJob();
		job.setDef3(reTeacherplan.getClassCourseChildId());
		job.setEvaluationTarget(new User(reTeacherplan.getTeacherId()));
		List<DbJob> list = dbJobDao.findList(job);
		if(list != null  && list.size()>0){
			for (DbJob dbJob : list) {
				if(!reTeacherplan.getFileUrl().equals(dbJob.getDef5()))
				dbJob.setDef5(reTeacherplan.getFileUrl());
				dbJobDao.update(dbJob);
			}
		}
		
	}
	
	@Transactional(readOnly = false)
	public void delete(ReTeacherplan reTeacherplan) {
		super.delete(reTeacherplan);
	}
	
}