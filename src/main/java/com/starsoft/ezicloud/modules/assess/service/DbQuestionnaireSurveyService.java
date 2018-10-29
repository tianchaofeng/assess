/**
 * Copyright &copy; 2012-2014 <a href="http://www.stars-soft.com">EziCloud</a> All rights reserved.
 */
package com.starsoft.ezicloud.modules.assess.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.starsoft.ezicloud.common.persistence.Page;
import com.starsoft.ezicloud.common.service.CrudService;
import com.starsoft.ezicloud.modules.assess.entity.DbQuestionnaireSurvey;
import com.starsoft.ezicloud.modules.assess.dao.DbQuestionnaireSurveyDao;
import com.starsoft.ezicloud.modules.sys.entity.User;
import com.starsoft.ezicloud.modules.sys.utils.UserUtils;

/**
 * 问卷调查Service
 * @author tcf
 * @version 2017-11-08
 */
@Service
@Transactional(readOnly = true)
public class DbQuestionnaireSurveyService extends CrudService<DbQuestionnaireSurveyDao, DbQuestionnaireSurvey> {

	public DbQuestionnaireSurvey get(String id) {
		return super.get(id);
	}
	
	public List<DbQuestionnaireSurvey> findList(DbQuestionnaireSurvey dbQuestionnaireSurvey) {
		
		return super.findList(dbQuestionnaireSurvey);
	}
	
	public Page<DbQuestionnaireSurvey> findPage(Page<DbQuestionnaireSurvey> page, DbQuestionnaireSurvey dbQuestionnaireSurvey) {
		User user = UserUtils.getUser();
		if(user.getUserType().equals("1")){//老师只看自己的
			dbQuestionnaireSurvey.setCreateBy(user);
		}
		return super.findPage(page, dbQuestionnaireSurvey);
	}
	
	@Transactional(readOnly = false)
	public void save(DbQuestionnaireSurvey dbQuestionnaireSurvey) {
		super.save(dbQuestionnaireSurvey);
	}
	
	@Transactional(readOnly = false)
	public void delete(DbQuestionnaireSurvey dbQuestionnaireSurvey) {
		super.delete(dbQuestionnaireSurvey);
	}
	
}