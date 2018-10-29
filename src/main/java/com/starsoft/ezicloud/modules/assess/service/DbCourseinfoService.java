/**
 * Copyright &copy; 2012-2014 <a href="http://www.stars-soft.com">EziCloud</a> All rights reserved.
 */
package com.starsoft.ezicloud.modules.assess.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.starsoft.ezicloud.common.persistence.Page;
import com.starsoft.ezicloud.common.service.CrudService;
import com.starsoft.ezicloud.modules.assess.entity.DbCourseinfo;
import com.starsoft.ezicloud.modules.assess.dao.DbCourseinfoDao;

/**
 * 科目添加Service
 * @author suxl
 * @version 2017-09-18
 */
@Service
@Transactional(readOnly = true)
public class DbCourseinfoService extends CrudService<DbCourseinfoDao, DbCourseinfo> {

	public DbCourseinfo get(String id) {
		return super.get(id);
	}
	
	public List<DbCourseinfo> findList(DbCourseinfo dbCourseinfo) {
		return super.findList(dbCourseinfo);
	}
	
	public Page<DbCourseinfo> findPage(Page<DbCourseinfo> page, DbCourseinfo dbCourseinfo) {
		return super.findPage(page, dbCourseinfo);
	}
	
	@Transactional(readOnly = false)
	public void save(DbCourseinfo dbCourseinfo) {
		super.save(dbCourseinfo);
	}
	
	@Transactional(readOnly = false)
	public void delete(DbCourseinfo dbCourseinfo) {
		super.delete(dbCourseinfo);
	}
	
}