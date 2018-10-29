/**
 * Copyright &copy; 2012-2014 <a href="http://www.stars-soft.com">EziCloud</a> All rights reserved.
 */
package com.starsoft.ezicloud.modules.assess.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.starsoft.ezicloud.common.persistence.Page;
import com.starsoft.ezicloud.common.service.CrudService;
import com.starsoft.ezicloud.modules.assess.entity.DbAssessIndex;
import com.starsoft.ezicloud.modules.assess.dao.DbAssessIndexDao;

/**
 * 考核指标Service
 * @author zsd
 * @version 2017-09-18
 */
@Service
@Transactional(readOnly = true)
public class DbAssessIndexService extends CrudService<DbAssessIndexDao, DbAssessIndex> {

	public DbAssessIndex get(String id) {
		return super.get(id);
	}
	
	public List<DbAssessIndex> findList(DbAssessIndex dbAssessIndex) {
		return super.findList(dbAssessIndex);
	}
	
	public Page<DbAssessIndex> findPage(Page<DbAssessIndex> page, DbAssessIndex dbAssessIndex) {
		return super.findPage(page, dbAssessIndex);
	}
	
	@Transactional(readOnly = false)
	public void save(DbAssessIndex dbAssessIndex) {
		super.save(dbAssessIndex);
	}
	
	@Transactional(readOnly = false)
	public void delete(DbAssessIndex dbAssessIndex) {
		super.delete(dbAssessIndex);
	}
	
}