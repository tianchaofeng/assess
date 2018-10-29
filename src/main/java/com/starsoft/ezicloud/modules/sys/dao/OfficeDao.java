/**
 * Copyright &copy; 2012-2016 <a href="http://www.stars-soft.com/">EziCloud</a> All rights reserved.
 */
package com.starsoft.ezicloud.modules.sys.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.starsoft.ezicloud.common.persistence.TreeDao;
import com.starsoft.ezicloud.common.persistence.annotation.MyBatisDao;
import com.starsoft.ezicloud.modules.sys.entity.Office;

/**
 * 机构DAO接口
 * @author EziCloud
 * @version 2014-05-16
 */
@MyBatisDao
public interface OfficeDao extends TreeDao<Office> {

	/*String getMaxByParentIds(Office office3);*/

	List<Office> getByType(Office office);
	
}
