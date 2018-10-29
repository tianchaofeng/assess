/**
 * Copyright &copy; 2012-2014 <a href="http://www.stars-soft.com">EziCloud</a> All rights reserved.
 */
package com.starsoft.ezicloud.modules.assess.dao;

import org.apache.ibatis.annotations.Param;

import com.starsoft.ezicloud.common.persistence.CrudDao;
import com.starsoft.ezicloud.common.persistence.annotation.MyBatisDao;
import com.starsoft.ezicloud.modules.assess.entity.ReJobSelefAssess;

/**
 * 个人任务与考核指标DAO接口
 * @author tcf
 * @version 2017-09-19
 */
@MyBatisDao
public interface ReJobSelefAssessDao extends CrudDao<ReJobSelefAssess> {
	public String sum(@Param("selefId") String selefId);
}