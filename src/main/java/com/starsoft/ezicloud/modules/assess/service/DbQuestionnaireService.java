/**
 * Copyright &copy; 2012-2014 <a href="http://www.stars-soft.com">EziCloud</a> All rights reserved.
 */
package com.starsoft.ezicloud.modules.assess.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.starsoft.ezicloud.common.persistence.Page;
import com.starsoft.ezicloud.common.service.CrudService;
import com.starsoft.ezicloud.common.utils.StringUtils;
import com.starsoft.ezicloud.modules.assess.entity.DbQuestionnaire;
import com.starsoft.ezicloud.modules.assess.dao.DbQuestionnaireDao;
import com.starsoft.ezicloud.modules.assess.entity.ReQuestionnaireAssess;
import com.starsoft.ezicloud.modules.assess.dao.ReQuestionnaireAssessDao;

/**
 * 问卷Service
 * @author zsd
 * @version 2017-09-19
 */
@Service
@Transactional(readOnly = true)
public class DbQuestionnaireService extends CrudService<DbQuestionnaireDao, DbQuestionnaire> {

	@Autowired
	private ReQuestionnaireAssessDao reQuestionnaireAssessDao;
	@Autowired
	private DbQuestionnaireDao dbQuestionnaireDao;
	
	public DbQuestionnaire get(String id) {
		DbQuestionnaire dbQuestionnaire = super.get(id);
		ReQuestionnaireAssess reQuestionnaireAssess = new ReQuestionnaireAssess();
		reQuestionnaireAssess.setQuestionnaireId(dbQuestionnaire);
		dbQuestionnaire.setReQuestionnaireAssessList(reQuestionnaireAssessDao.findList(reQuestionnaireAssess));
		return dbQuestionnaire;
	}
	
	public List<DbQuestionnaire> findList(DbQuestionnaire dbQuestionnaire) {
		return super.findList(dbQuestionnaire);
	}
	
	public Page<DbQuestionnaire> findPage(Page<DbQuestionnaire> page, DbQuestionnaire dbQuestionnaire) {
		return super.findPage(page, dbQuestionnaire);
	}
	
	@Transactional(readOnly = false)
	public void save(DbQuestionnaire dbQuestionnaire) {
		super.save(dbQuestionnaire);
		int score =0;
		for (ReQuestionnaireAssess reQuestionnaireAssess : dbQuestionnaire.getReQuestionnaireAssessList()){
			if (reQuestionnaireAssess.getId() == null){
				continue;
			}
			if (ReQuestionnaireAssess.DEL_FLAG_NORMAL.equals(reQuestionnaireAssess.getDelFlag())){
				score++;
				if (StringUtils.isBlank(reQuestionnaireAssess.getId())){
					reQuestionnaireAssess.setQuestionnaireId(dbQuestionnaire);
					reQuestionnaireAssess.preInsert();
					reQuestionnaireAssessDao.insert(reQuestionnaireAssess);
				}else{
					reQuestionnaireAssess.preUpdate();
					reQuestionnaireAssessDao.update(reQuestionnaireAssess);
				}
			}else{
				reQuestionnaireAssessDao.delete(reQuestionnaireAssess);
			}
		}
		dbQuestionnaire.setScore(String.valueOf(score*5));
		dbQuestionnaireDao.update(dbQuestionnaire);
	}
	
	@Transactional(readOnly = false)
	public void delete(DbQuestionnaire dbQuestionnaire) {
		super.delete(dbQuestionnaire);
		for(ReQuestionnaireAssess assess : dbQuestionnaire.getReQuestionnaireAssessList()){
			
			reQuestionnaireAssessDao.delete(assess);
		}
	}
	
}