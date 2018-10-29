/**
 * Copyright &copy; 2012-2014 <a href="http://www.stars-soft.com">EziCloud</a> All rights reserved.
 */
package com.starsoft.ezicloud.modules.assess.dao;

import java.util.List;
import java.util.Map;

import com.starsoft.ezicloud.common.persistence.CrudDao;
import com.starsoft.ezicloud.common.persistence.annotation.MyBatisDao;
import com.starsoft.ezicloud.modules.assess.entity.DbJob;

/**
 * 任务创建DAO接口
 * @author suxl
 * @version 2017-09-19
 */
@MyBatisDao
public interface DbJobDao extends CrudDao<DbJob> {
	List<Map<String,Object>> avg(String jobId);
}