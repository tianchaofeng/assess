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
import com.starsoft.ezicloud.modules.assess.entity.DbJob;
import com.starsoft.ezicloud.modules.assess.entity.DbJobSelf;
import com.starsoft.ezicloud.modules.sys.dao.UserDao;
import com.starsoft.ezicloud.modules.sys.entity.Role;
import com.starsoft.ezicloud.modules.sys.entity.User;
import com.starsoft.ezicloud.modules.sys.utils.UserUtils;
import com.starsoft.ezicloud.modules.assess.dao.DbJobSelfDao;

/**
 * 个人任务Service
 * @author tcf
 * @version 2017-09-19
 */
@Service
@Transactional(readOnly = true)
public class DbJobSelfService extends CrudService<DbJobSelfDao, DbJobSelf> {

	@Autowired
	private UserDao userDao;
	
	public DbJobSelf get(String id) {
		return super.get(id);
	}
	
	public List<DbJobSelf> findList(DbJobSelf dbJobSelf) {
		return super.findList(dbJobSelf);
	}
	
	public Page<DbJobSelf> findPage(Page<DbJobSelf> page, DbJobSelf dbJobSelf) {
		User user = UserUtils.getUser();
		/**教师看目标是自己的，评价者只看自己要评的*/
		/*List<Role> roleList = user.getRoleList();
		for (Role role : roleList) {
			 if(role.getName().equals("老师")){
				dbJobSelf.setTarget(user);
				break;
			}else if(role.getName().equals("评价人") || role.getName().equals("老师")){
				dbJobSelf.setParticipant(user);
			}
		}*/
		if(!user.getId().equals("1")){
			/**只看自己的任务*/
			dbJobSelf.setParticipant(user);
		}
		
		
		
		return super.findPage(page, dbJobSelf);
	}
	
	@Transactional(readOnly = false)
	public void save(DbJobSelf dbJobSelf) {
		super.save(dbJobSelf);
	}
	
	@Transactional(readOnly = false)
	public void delete(DbJobSelf dbJobSelf) {
		super.delete(dbJobSelf);
	}
	
}