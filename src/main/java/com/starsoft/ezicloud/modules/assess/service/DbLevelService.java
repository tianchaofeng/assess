/**
 * Copyright &copy; 2012-2014 <a href="http://www.stars-soft.com">EziCloud</a> All rights reserved.
 */
package com.starsoft.ezicloud.modules.assess.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.starsoft.ezicloud.common.service.TreeService;
import com.starsoft.ezicloud.common.utils.StringUtils;
import com.starsoft.ezicloud.modules.assess.entity.DbLevel;
import com.starsoft.ezicloud.modules.assess.dao.DbLevelDao;

/**
 * 评价级别Service
 * @author zsd
 * @version 2017-09-18
 */
@Service
@Transactional(readOnly = true)
public class DbLevelService extends TreeService<DbLevelDao, DbLevel> {

	public DbLevel get(String id) {
		return super.get(id);
	}
	
	public List<DbLevel> findList(DbLevel dbLevel) {
		if (StringUtils.isNotBlank(dbLevel.getParentIds())){
			dbLevel.setParentIds(","+dbLevel.getParentIds()+",");
		}
		return super.findList(dbLevel);
	}
	
	@Transactional(readOnly = false)
	public void save(DbLevel dbLevel) {
		super.save(dbLevel);
	}
	
	@Transactional(readOnly = false)
	public void delete(DbLevel dbLevel) {
		super.delete(dbLevel);
	}
	
}