/**
 * Copyright &copy; 2012-2014 <a href="http://www.stars-soft.com">EziCloud</a> All rights reserved.
 */
package com.starsoft.ezicloud.modules.assess.web;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.starsoft.ezicloud.common.config.Global;
import com.starsoft.ezicloud.common.persistence.Page;
import com.starsoft.ezicloud.common.web.BaseController;
import com.starsoft.ezicloud.common.utils.DateUtils;
import com.starsoft.ezicloud.common.utils.StringUtils;
import com.starsoft.ezicloud.common.utils.excel.ExportExcel;
import com.starsoft.ezicloud.modules.assess.entity.ReTeacherplan;
import com.starsoft.ezicloud.modules.assess.service.ReTeacherplanService;

/**
 * 教案Controller
 * @author tcf
 * @version 2017-12-22
 */
@Controller
@RequestMapping(value = "${adminPath}/assess/reTeacherplan")
public class ReTeacherplanController extends BaseController {

	@Autowired
	private ReTeacherplanService reTeacherplanService;
	
	@ModelAttribute
	public ReTeacherplan get(@RequestParam(required=false) String id) {
		ReTeacherplan entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = reTeacherplanService.get(id);
		}
		if (entity == null){
			entity = new ReTeacherplan();
		}
		return entity;
	}
	
	@RequiresPermissions("assess:reTeacherplan:view")
	@RequestMapping(value = {"list", ""})
	public String list(ReTeacherplan reTeacherplan, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ReTeacherplan> page = reTeacherplanService.findPage(new Page<ReTeacherplan>(request, response), reTeacherplan); 
		model.addAttribute("page", page);
		return "modules/assess/reTeacherplanList";
	}
	@RequestMapping(value = "geturl", method=RequestMethod.POST)
	@ResponseBody
	public String geturl(@RequestParam("teacherid") String teacherid,@RequestParam("crousechildid")String crousechildid, HttpServletRequest request, HttpServletResponse response) {
		ReTeacherplan reTeacherplan = new ReTeacherplan() ;
		reTeacherplan.setTeacherId(teacherid);
		reTeacherplan.setClassCourseChildId(crousechildid);
		List<ReTeacherplan> list = reTeacherplanService.findList(reTeacherplan);
		if(list != null && list.size()>0){
			return list.get(0).getFileUrl();
		}else{
			return "暂未上传";
		}
	}

	@RequiresPermissions("assess:reTeacherplan:view")
	@RequestMapping(value = "form")
	public String form(ReTeacherplan reTeacherplan, Model model) {
		model.addAttribute("reTeacherplan", reTeacherplan);
		return "modules/assess/reTeacherplanForm";
	}

	@RequiresPermissions("assess:reTeacherplan:view")
	@RequestMapping(value = "detail")
	public String detail(ReTeacherplan reTeacherplan, Model model) {
		model.addAttribute("reTeacherplan", reTeacherplan);
		return "modules/assess/reTeacherplanDetail";
	}

	@RequiresPermissions("assess:reTeacherplan:edit")
	@RequestMapping(value = "save")
	public String save(ReTeacherplan reTeacherplan, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, reTeacherplan)){
			return form(reTeacherplan, model);
		}
		reTeacherplanService.save(reTeacherplan);
		addMessage(redirectAttributes, "保存教案成功");
		return "redirect:"+Global.getAdminPath()+"/assess/reTeacherplan/?repage";
	}
	
	@RequiresPermissions("assess:reTeacherplan:edit")
	@RequestMapping(value = "delete")
	public String delete(ReTeacherplan reTeacherplan, RedirectAttributes redirectAttributes) {
		reTeacherplanService.delete(reTeacherplan);
		addMessage(redirectAttributes, "删除教案成功");
		return "redirect:"+Global.getAdminPath()+"/assess/reTeacherplan/?repage";
	}
	
	@RequiresPermissions("assess:reTeacherplan:view")
	@RequestMapping(value = "export", method = RequestMethod.POST)
	public String exportFile(ReTeacherplan reTeacherplan, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String fileName = "教案" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<ReTeacherplan> page = reTeacherplanService.findPage(new Page<ReTeacherplan>(request, response, -1), reTeacherplan);
			// 解决firefox下载中文无法显示的问题
			String UserAgent = request.getHeader("USER-AGENT").toLowerCase();
			new ExportExcel("教案", ReTeacherplan.class).setDataList(page.getList()).write(response, fileName, !UserAgent.contains("firefox")).dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出教案失败！失败信息：" + e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/assess/reTeacherplan/list?repage";
	}
	
	@RequiresPermissions("assess:reTeacherplan:view")
	@RequestMapping(value = "reference", method = RequestMethod.POST)
	public String selectList(ReTeacherplan reTeacherplan, HttpServletRequest request, HttpServletResponse response, Model model) {
		list(reTeacherplan, request, response, model);
		return "modules/assess/reTeacherplanReferenceList";
	}

}