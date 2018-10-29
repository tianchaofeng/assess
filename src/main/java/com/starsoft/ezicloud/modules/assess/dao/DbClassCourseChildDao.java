/**
 * Copyright &copy; 2012-2014 <a href="http://www.stars-soft.com">EziCloud</a> All rights reserved.
 */
package com.starsoft.ezicloud.modules.assess.dao;

import com.starsoft.ezicloud.common.persistence.CrudDao;
import com.starsoft.ezicloud.common.persistence.annotation.MyBatisDao;
import com.starsoft.ezicloud.modules.assess.entity.DbClassCourseChild;

/**
 * 班级课程信息DAO接口
 * @author suxl
 * @version 2017-10-10
 */
@MyBatisDao
public interface DbClassCourseChildDao extends CrudDao<DbClassCourseChild> {
	
}