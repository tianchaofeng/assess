/**
 * Copyright &copy; 2012-2014 <a href="http://www.stars-soft.com">EziCloud</a> All rights reserved.
 */
package com.starsoft.ezicloud.modules.assess.web;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.starsoft.ezicloud.common.config.Global;
import com.starsoft.ezicloud.common.persistence.Page;
import com.starsoft.ezicloud.common.web.BaseController;
import com.starsoft.ezicloud.common.utils.DateUtils;
import com.starsoft.ezicloud.common.utils.StringUtils;
import com.starsoft.ezicloud.common.utils.excel.ExportExcel;
import com.starsoft.ezicloud.modules.assess.dao.DbLevelDao;
import com.starsoft.ezicloud.modules.assess.entity.DbAssessIndex;
import com.starsoft.ezicloud.modules.assess.entity.DbLevel;
import com.starsoft.ezicloud.modules.assess.service.DbAssessIndexService;

/**
 * 评价指标Controller
 * @author zsd
 * @version 2017-09-18
 */
@Controller
@RequestMapping(value = "${adminPath}/assess/dbAssessIndex")
public class DbAssessIndexController extends BaseController {

	@Autowired
	private DbAssessIndexService dbAssessIndexService;
	@Autowired
	private DbLevelDao dbLevelDao;
	
	@ModelAttribute
	public DbAssessIndex get(@RequestParam(required=false) String id) {
		DbAssessIndex entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = dbAssessIndexService.get(id);
		}
		if (entity == null){
			entity = new DbAssessIndex();
		}
		return entity;
	}
	
	@RequiresPermissions("assess:dbAssessIndex:view")
	@RequestMapping(value = {"index", ""})
	public String index(DbAssessIndex dbAssessIndex, HttpServletRequest request, HttpServletResponse response, Model model) {
		return "modules/assess/dbAssessIndexIndex";
	}
	@RequiresPermissions("assess:dbAssessIndex:view")
	@RequestMapping(value = {"list", ""})
	public String list(DbAssessIndex dbAssessIndex, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(!"3".equals(dbAssessIndex.getDef2()) && StringUtils.isNotBlank(dbAssessIndex.getDef2())){
			dbAssessIndex.setDef1(dbAssessIndex.getDef1()+","+dbAssessIndex.getLevelId().getId());
			dbAssessIndex.setLevelId(null);
		}else{
			dbAssessIndex.setDef1(null);
		}
		Page<DbAssessIndex> page = dbAssessIndexService.findPage(new Page<DbAssessIndex>(request, response), dbAssessIndex); 
		model.addAttribute("page", page);
		return "modules/assess/dbAssessIndexList";
	}

	@RequiresPermissions("assess:dbAssessIndex:view")
	@RequestMapping(value = "form")
	public String form(DbAssessIndex dbAssessIndex, Model model) {
		model.addAttribute("dbAssessIndex", dbAssessIndex);
		return "modules/assess/dbAssessIndexForm";
	}

	@RequiresPermissions("assess:dbAssessIndex:view")
	@RequestMapping(value = "detail")
	public String detail(DbAssessIndex dbAssessIndex, Model model) {
		model.addAttribute("dbAssessIndex", dbAssessIndex);
		return "modules/assess/dbAssessIndexDetail";
	}

	@RequiresPermissions("assess:dbAssessIndex:edit")
	@RequestMapping(value = "save")
	public String save(DbAssessIndex dbAssessIndex, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, dbAssessIndex)){
			return form(dbAssessIndex, model);
		}
		dbAssessIndexService.save(dbAssessIndex);
		addMessage(redirectAttributes, "保存评价指标成功");
		return "redirect:"+Global.getAdminPath()+"/assess/dbAssessIndex/list?repage";
	}
	
	@RequiresPermissions("assess:dbAssessIndex:edit")
	@RequestMapping(value = "delete")
	public String delete(DbAssessIndex dbAssessIndex, RedirectAttributes redirectAttributes) {
		dbAssessIndexService.delete(dbAssessIndex);
		addMessage(redirectAttributes, "删除评价指标成功");
		return "redirect:"+Global.getAdminPath()+"/assess/dbAssessIndex/list?repage";
	}
	
	@RequiresPermissions("assess:dbAssessIndex:view")
	@RequestMapping(value = "export", method = RequestMethod.POST)
	public String exportFile(DbAssessIndex dbAssessIndex, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String fileName = "评价指标" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<DbAssessIndex> page = dbAssessIndexService.findPage(new Page<DbAssessIndex>(request, response, -1), dbAssessIndex);
			// 解决firefox下载中文无法显示的问题
			String UserAgent = request.getHeader("USER-AGENT").toLowerCase();
			new ExportExcel("评价指标", DbAssessIndex.class).setDataList(page.getList()).write(response, fileName, !UserAgent.contains("firefox")).dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出评价指标失败！失败信息：" + e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/assess/dbAssessIndex/list?repage";
	}
	
	@RequiresPermissions("assess:dbAssessIndex:view")
	@RequestMapping(value = "reference", method = RequestMethod.POST)
	public String selectList(DbAssessIndex dbAssessIndex,String assessids, HttpServletRequest request, HttpServletResponse response, Model model) {
		assessids = assessids == null ? "":assessids;
		String[] strings = assessids.split(",");
		List<String> asList = Arrays.asList(strings);
		dbAssessIndex.setList(asList);
		Page<DbAssessIndex> page = dbAssessIndexService.findPage(new Page<DbAssessIndex>(request, response), dbAssessIndex); 
		List<DbAssessIndex> list = page.getList();
		for(DbAssessIndex assessIndex : list){
			String levelId = assessIndex.getLevelId().getId();
			DbLevel dbLevel3 = dbLevelDao.get(levelId);
			String parentIds = dbLevel3.getParentIds();
			String[] split = parentIds.split(",");
			DbLevel dbLevel1 = dbLevelDao.get(split[1]);
			DbLevel dbLevel2 = dbLevelDao.get(split[2]);
			assessIndex.setLevelId1(dbLevel1);
			assessIndex.setLevelId2(dbLevel2);
		}
		model.addAttribute("page", page);
		return "modules/assess/dbAssessIndexReferenceList";
	}

}