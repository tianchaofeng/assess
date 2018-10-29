/**
 * Copyright &copy; 2012-2014 <a href="http://www.stars-soft.com">EziCloud</a> All rights reserved.
 */
package com.starsoft.ezicloud.modules.assess.dao;

import com.starsoft.ezicloud.common.persistence.CrudDao;
import com.starsoft.ezicloud.common.persistence.annotation.MyBatisDao;
import com.starsoft.ezicloud.modules.assess.entity.DbQuestionnaireSurvey;

/**
 * 问卷调查DAO接口
 * @author tcf
 * @version 2017-11-08
 */
@MyBatisDao
public interface DbQuestionnaireSurveyDao extends CrudDao<DbQuestionnaireSurvey> {
	
}