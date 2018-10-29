/**
 * Copyright &copy; 2012-2014 <a href="http://www.stars-soft.com">EziCloud</a> All rights reserved.
 */
package com.starsoft.ezicloud.modules.assess.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.starsoft.ezicloud.common.config.Global;
import com.starsoft.ezicloud.common.web.BaseController;
import com.starsoft.ezicloud.common.utils.StringUtils;
import com.starsoft.ezicloud.modules.assess.entity.DbLevel;
import com.starsoft.ezicloud.modules.assess.service.DbLevelService;

/**
 * 评价级别Controller
 * @author zsd
 * @version 2017-09-18
 */
@Controller
@RequestMapping(value = "${adminPath}/assess/dbLevel")
public class DbLevelController extends BaseController {

	@Autowired
	private DbLevelService dbLevelService;
	
	@ModelAttribute
	public DbLevel get(@RequestParam(required=false) String id) {
		DbLevel entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = dbLevelService.get(id);
		}
		if (entity == null){
			entity = new DbLevel();
		}
		return entity;
	}
	
	@RequiresPermissions("assess:dbLevel:view")
	@RequestMapping(value = {"list", ""})
	public String list(DbLevel dbLevel, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<DbLevel> list = dbLevelService.findList(dbLevel);
		model.addAttribute("list", list);
		return "modules/assess/dbLevelList";
	}

	@RequiresPermissions("assess:dbLevel:view")
	@RequestMapping(value = "form")
	public String form(DbLevel dbLevel, Model model) {
		if (dbLevel.getParent()!=null && StringUtils.isNotBlank(dbLevel.getParent().getId())){
			dbLevel.setParent(dbLevelService.get(dbLevel.getParent().getId()));
			// 获取排序号，最末节点排序号+30
			if (StringUtils.isBlank(dbLevel.getId())){
				DbLevel dbLevelChild = new DbLevel();
				dbLevelChild.setParent(new DbLevel(dbLevel.getParent().getId()));
				List<DbLevel> list = dbLevelService.findList(dbLevel); 
				if (list.size() > 0){
					dbLevel.setSort(list.get(list.size()-1).getSort());
					if (dbLevel.getSort() != null){
						dbLevel.setSort(dbLevel.getSort() + 30);
					}
				}
			}
		}
		if (dbLevel.getSort() == null){
			dbLevel.setSort(30);
		}
		model.addAttribute("dbLevel", dbLevel);
		return "modules/assess/dbLevelForm";
	}

	@RequiresPermissions("assess:dbLevel:edit")
	@RequestMapping(value = "save")
	public String save(DbLevel dbLevel, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, dbLevel)){
			return form(dbLevel, model);
		}
		if(StringUtils.isBlank(dbLevel.getParent().getId())){
			dbLevel.setLevel("1");
		}else{
			String id = dbLevel.getParent().getId();
			DbLevel level = dbLevelService.get(id);
			String parentIds = level.getParentIds();
			String[] split = parentIds.split(",");
			int a = split.length;
			dbLevel.setLevel(a+1+"");
		}
		dbLevelService.save(dbLevel);
		addMessage(redirectAttributes, "保存评价级别成功");
		return "redirect:"+Global.getAdminPath()+"/assess/dbLevel/?repage";
	}
	
	@RequiresPermissions("assess:dbLevel:edit")
	@RequestMapping(value = "delete")
	public String delete(DbLevel dbLevel, RedirectAttributes redirectAttributes) {
		dbLevelService.delete(dbLevel);
		addMessage(redirectAttributes, "删除评价级别成功");
		return "redirect:"+Global.getAdminPath()+"/assess/dbLevel/?repage";
	}

	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(@RequestParam(required=false) String extId, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<DbLevel> list = dbLevelService.findList(new DbLevel());
		for (int i=0; i<list.size(); i++){
			DbLevel e = list.get(i);
			if (StringUtils.isBlank(extId) || (extId!=null && !extId.equals(e.getId()) && e.getParentIds().indexOf(","+extId+",")==-1)){
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", e.getId());
				map.put("pId", e.getParentId());
				map.put("name", e.getName());
				map.put("levelId", e.getLevel());
				mapList.add(map);
			}
		}
		return mapList;
	}
	
}