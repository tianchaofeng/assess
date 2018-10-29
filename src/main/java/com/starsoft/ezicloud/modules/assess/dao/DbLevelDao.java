/**
 * Copyright &copy; 2012-2014 <a href="http://www.stars-soft.com">EziCloud</a> All rights reserved.
 */
package com.starsoft.ezicloud.modules.assess.dao;

import com.starsoft.ezicloud.common.persistence.TreeDao;
import com.starsoft.ezicloud.common.persistence.annotation.MyBatisDao;
import com.starsoft.ezicloud.modules.assess.entity.DbLevel;

/**
 * 评价级别DAO接口
 * @author zsd
 * @version 2017-09-18
 */
@MyBatisDao
public interface DbLevelDao extends TreeDao<DbLevel> {
	
}