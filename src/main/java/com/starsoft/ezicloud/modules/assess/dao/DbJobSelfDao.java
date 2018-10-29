/**
 * Copyright &copy; 2012-2014 <a href="http://www.stars-soft.com">EziCloud</a> All rights reserved.
 */
package com.starsoft.ezicloud.modules.assess.dao;

import java.util.List;

import com.starsoft.ezicloud.common.persistence.CrudDao;
import com.starsoft.ezicloud.common.persistence.annotation.MyBatisDao;
import com.starsoft.ezicloud.modules.assess.entity.DbJobSelf;

/**
 * 个人任务DAO接口
 * @author tcf
 * @version 2017-09-19
 */
@MyBatisDao
public interface DbJobSelfDao extends CrudDao<DbJobSelf> {

	void deleteById(DbJobSelf dbJobSelf);

	List<DbJobSelf> getByJobId(String id);
	
}