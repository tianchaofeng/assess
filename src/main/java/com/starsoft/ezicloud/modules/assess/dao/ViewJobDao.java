/**
 * Copyright &copy; 2012-2014 <a href="http://www.stars-soft.com">EziCloud</a> All rights reserved.
 */
package com.starsoft.ezicloud.modules.assess.dao;

import java.util.List;

import com.starsoft.ezicloud.common.persistence.CrudDao;
import com.starsoft.ezicloud.common.persistence.annotation.MyBatisDao;
import com.starsoft.ezicloud.modules.assess.entity.ViewJob;
import com.starsoft.ezicloud.modules.assess.utilts.SqlObject;

/**
 * 任务统计DAO接口
 * @author tcf
 * @version 2017-09-27
 */
@MyBatisDao
public interface ViewJobDao extends CrudDao<ViewJob> {
	public List<ViewJob> findListgroup(SqlObject sqlobject);
}