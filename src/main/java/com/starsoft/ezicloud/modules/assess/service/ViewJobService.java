/**
 * Copyright &copy; 2012-2014 <a href="http://www.stars-soft.com">EziCloud</a> All rights reserved.
 */
package com.starsoft.ezicloud.modules.assess.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.starsoft.ezicloud.common.persistence.Page;
import com.starsoft.ezicloud.common.service.CrudService;
import com.starsoft.ezicloud.modules.assess.entity.ViewJob;
import com.starsoft.ezicloud.modules.assess.dao.ViewJobDao;

/**
 * 任务统计Service
 * @author tcf
 * @version 2017-09-27
 */
@Service
@Transactional(readOnly = true)
public class ViewJobService extends CrudService<ViewJobDao, ViewJob> {

	public ViewJob get(String id) {
		return super.get(id);
	}
	
	public List<ViewJob> findList(ViewJob viewJob) {
		return super.findList(viewJob);
	}
	
	public Page<ViewJob> findPage(Page<ViewJob> page, ViewJob viewJob) {
		return super.findPage(page, viewJob);
	}
	
	@Transactional(readOnly = false)
	public void save(ViewJob viewJob) {
		super.save(viewJob);
	}
	
	@Transactional(readOnly = false)
	public void delete(ViewJob viewJob) {
		super.delete(viewJob);
	}
	
}