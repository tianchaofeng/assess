/**
 * Copyright &copy; 2012-2014 <a href="http://www.stars-soft.com">EziCloud</a> All rights reserved.
 */
package com.starsoft.ezicloud.modules.assess.dao;

import com.starsoft.ezicloud.common.persistence.CrudDao;
import com.starsoft.ezicloud.common.persistence.annotation.MyBatisDao;
import com.starsoft.ezicloud.modules.assess.entity.ReQuestionnaireAssess;

/**
 * 问卷DAO接口
 * @author zsd
 * @version 2017-09-19
 */
@MyBatisDao
public interface ReQuestionnaireAssessDao extends CrudDao<ReQuestionnaireAssess> {
	
}