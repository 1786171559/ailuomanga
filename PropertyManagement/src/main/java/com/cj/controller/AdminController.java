package com.cj.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.cj.pojo.Resources;
import com.cj.pojo.RoleInfo;
import com.cj.pojo.RoleResource;
import com.cj.service.IResourcesService;
import com.cj.service.IRoleInfoService;
import com.cj.service.IRoleResourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.management.relation.Role;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/19 9:28
 */
@Controller
@RequestMapping("admin")
public class AdminController {
    @Autowired
    private IRoleInfoService roleInfoService;
    @Autowired
    private IRoleResourceService roleResourceService;

    @Autowired
    private IResourcesService resourcesService;

    @RequestMapping("/role-info")
    public ModelAndView returnRoleInfo() {
        ModelAndView modelAndView = new ModelAndView("/role-info");
        return modelAndView;
    }

    @RequestMapping("/getRoleInfo")
    @ResponseBody
    public Map<String, Object> getRoleInfo(Integer page, Integer limit) {
        //创建map对象
        Map<String, Object> map = new HashMap<String, Object>();
        //获取分页对象page，存储分页角色数据
        Page<RoleInfo> pages = roleInfoService.selectPage(new Page<RoleInfo>(page, limit),
                new EntityWrapper<RoleInfo>().eq("isDelete", 1));
        //layui固定格式，添加map对象
        map.put("code", 0);
        map.put("count", pages.getTotal());
        map.put("data", pages.getRecords());
        map.put("msg", "");
        return map;
    }

    /**
     * 删除角色
     * 注意：删除角色时，需要同时删除角色对应资源
     *
     * @param roleId
     * @return
     */
    @RequestMapping("/delRoleByRoleId")
    @ResponseBody
    public Map<String, Object> delRoleByRoleId(Integer roleId) {
        //创建map对象
        Map<String, Object> map = new HashMap<String, Object>();
        //删除角色
        if (roleInfoService.delete(new EntityWrapper<RoleInfo>().eq("roleId", roleId))) {
            //删除角色对应资源
            if (roleResourceService.delete(new EntityWrapper<RoleResource>().eq("roleId", roleId))) {
                map.put("flag", "success");
            }
        } else {
            map.put("flag", "fail");
        }
        return map;
    }

    /**
     * 删除多个角色
     *
     * @param
     * @return
     */
    @RequestMapping("/delRoleByRoleIds")
    @ResponseBody
    public Map<String, Object> delRoleByRoleIds(Integer[] roleIds) {
        //创建map对象
        Map<String, Object> map = new HashMap<String, Object>();
        for (Integer roleId : roleIds) {
            if (roleInfoService.delete(new EntityWrapper<RoleInfo>().eq("roleId", roleId))) {
                roleResourceService.delete(new EntityWrapper<RoleResource>().eq("roleId", roleId));
            }
        }
        map.put("flag", "success");
        return map;
    }

    /**
     * 根据角色id获取角色信息，并跳转到角色编辑界面
     *
     * @param roleId
     */
    @RequestMapping("/getOneRoleInfoById/{roleId}")
    public ModelAndView getOneRoleInfoById(@PathVariable(name = "roleId") Integer roleId) {
        ModelAndView modelAndView = new ModelAndView("role-edit");
        RoleInfo roleInfo = roleInfoService.selectOne(new EntityWrapper<RoleInfo>().eq("roleId", roleId));
        System.out.println(roleInfo);
        modelAndView.addObject("roleInfo",
                roleInfoService.selectOne(new EntityWrapper<RoleInfo>().eq("roleId", roleId)));
        return modelAndView;
    }

    /**
     * 修改角色信息
     *
     * @param roleId
     * @param roleName
     */
    @RequestMapping("/changeRoleById")
    @ResponseBody
    public Map<String, Object> changeRoleById(Integer roleId, String roleName) {
        //创建map对象
        Map<String, Object> map = new HashMap<String, Object>();
        //创建RoleInfo对象
        RoleInfo roleInfo = new RoleInfo();
        //给对象属性赋值
        roleInfo.setRoleId(roleId);
        roleInfo.setRoleName(roleName);
        //更新角色信息
        if (roleInfoService.updateById(roleInfo)) {
            map.put("flag", "success");
        } else {
            map.put("flag", "fail");
        }
        return map;
    }

    /**
     * 新增角色
     *
     * @param roleName
     */
    @RequestMapping("/addRole")
    @ResponseBody
    public Map<String, Object> addRole(String roleName) {
        //创建map对象
        Map<String, Object> map = new HashMap<String, Object>();
        //创建RoleInfo对象
        RoleInfo roleInfo = new RoleInfo();
        //给对象属性赋值
        roleInfo.setRoleName(roleName);
        if (roleInfoService.selectCount(new EntityWrapper<RoleInfo>().eq("roleName", roleName)) > 0) {
            map.put("flag", "roleIsExit");
        } else {
            //新增角色信息
            if (roleInfoService.insert(roleInfo)) {
                map.put("flag", "success");
            } else {
                map.put("flag", "fail");
            }
        }
        return map;
    }

    /**
     * 分配资源时，获取父级资源
     *
     * @return
     */
    @RequestMapping("/getParentResource/{roleId}")
    public ModelAndView getParentResource(@PathVariable(name = "roleId") Integer roleId) {
        ModelAndView modelAndView = new ModelAndView("do_roleResource");
        List<Resources> resources = resourcesService.selectList(
                new EntityWrapper<Resources>().eq("resLevel", 0));
        modelAndView.addObject("resources", resources);
        modelAndView.addObject("roleId", roleId);
        return modelAndView;
    }

    /**
     * 获取角色资源
     */
    @RequestMapping("/getRoleResourcesByRoleId")
    @ResponseBody
    public Map<String, Object> getRoleResourcesByRoleId(Integer resId, Integer roleId) {
        //创建map对象
        Map<String, Object> map = new HashMap<String, Object>();
        List<Resources> resources = resourcesService.getResourceChild(resId);
        map.put("resources", resources);
        List<Resources> resourcesList = resourcesService.getRoleReSourcesByRoleId(roleId);
        map.put("RoleReSources", resourcesList);
        map.put("flag", "success");
        return map;
    }

    /**
     * 新增角色资源
     * 注意：先删除角色在该父级目录下的资源，在新增资源
     *
     * @return
     */
    //addRoleResource
    @RequestMapping("/addRoleResource")
    @ResponseBody
    public Map<String, Object> addRoleResource(Integer roleId, Integer parentId, @RequestParam(defaultValue = "") Integer[] resId) {
        //创建map对象
        Map<String, Object> map = new HashMap<String, Object>();
        //删除角色在该父级目录下的资源,其中第一个parentId代表父级目录,第二个parentId代表删除resId为parentId的资源
        roleResourceService.deleteRoleResources(roleId, parentId,parentId);
        //首先新增子目录的父目录资源
        RoleResource roleResource = new RoleResource();
        roleResource.setRoleId(roleId);
        roleResource.setResId(parentId);
        //新增角色资源
        roleResourceService.insert(roleResource);
        for (Integer resid : resId) {
            roleResource = new RoleResource();
            roleResource.setRoleId(roleId);
            roleResource.setResId(resid);
            //新增角色资源
            roleResourceService.insert(roleResource);
        }
        map.put("flag", "success");
        return map;
    }

    /**
     * 点击资源列表时，跳转对应jsp界面
     *
     * @return
     */
    @RequestMapping("/resource-info")
    public String returnResourceJsp() {
        return "resource-info";
    }

    @RequestMapping("/getResources")
    @ResponseBody
    public Map<String, Object> getResources(Integer page, Integer limit) {
        //创建map对象
        Map<String, Object> map = new HashMap<String, Object>();
        //分页获取对象page，存储分页资源信息
        Page<Resources> pages = resourcesService.selectPage(new Page<Resources>(page, limit), null);
        //layui固定格式，添加map对象
        map.put("code", 0);
        map.put("count", pages.getTotal());
        map.put("data", pages.getRecords());
        map.put("msg", "");
        return map;
    }

    /**
     * 删除资源
     *
     * @param resId
     * @return
     */
    @RequestMapping("/delResourceByResId")
    @ResponseBody
    public Map<String, Object> delResourceByResId(Integer resId) {
        System.out.println("资源id" + resId);
        //创建map对象
        Map<String, Object> map = new HashMap<String, Object>();
        if (resourcesService.delete(new EntityWrapper<Resources>().eq("resId", resId))) {
            map.put("flag", "success");
        } else {
            map.put("flag", "fail");
        }
        return map;
    }

    /**
     * 删除多个资源
     *
     * @return
     */
    @RequestMapping("/delResourceByResIds")
    @ResponseBody
    public Map<String, Object> delResourceByResIds(Integer[] resIds) {
        //创建map对象
        Map<String, Object> map = new HashMap<String, Object>();
        for (Integer resId : resIds) {
            resourcesService.delete(new EntityWrapper<Resources>().eq("resId", resId));
        }
        map.put("flag", "success");
        return map;
    }

    /**
     * 当点击编辑按钮时，获取当前点击对象的资源信息，并跳转到编辑界面
     *
     * @param resId
     * @return
     */
    @RequestMapping("/getOneResourceById/{resId}")
    public ModelAndView getOneResourceById(@PathVariable(name = "resId") Integer resId) {
        ModelAndView modelAndView = new ModelAndView("resource-edit");
        modelAndView.addObject("resource", resourcesService.selectOne(
                new EntityWrapper<Resources>().eq("resId", resId)));
        return modelAndView;
    }

    /**
     * 修改资源
     *
     * @param resources
     */
    @RequestMapping("/changeResource")
    @ResponseBody
    public Map<String, Object> changeResource(Resources resources) {
        //创建map对象
        Map<String, Object> map = new HashMap<String, Object>();
        System.out.println("资源：" + resources);
        if (resourcesService.updateById(resources)) {
            map.put("flag", "success");
        } else {
            map.put("flag", "fail");
        }
        return map;
    }

    /**
     * 获取资源父级目录,并跳转到新增界面
     */
    @RequestMapping("/getParentResources")
    public ModelAndView getParentResources() {
        ModelAndView modelAndView = new ModelAndView("resource-add");
        List<Resources> resources = resourcesService.selectList(
                new EntityWrapper<Resources>().eq("resLevel", 0));
        modelAndView.addObject("resources", resources);
        return modelAndView;
    }

    /**
     * 新增资源
     */
    @RequestMapping("/addResource")
    @ResponseBody
    public Map<String, Object> addResource(String resName, String resUrl, Integer parentId) {

        //创建map对象
        Map<String, Object> map = new HashMap<String, Object>();
        //判断是否存在该资源名称
        if (resourcesService.selectCount(new EntityWrapper<Resources>().eq("resName", resName)) > 0) {
            map.put("flag", "resNameIsExit");
            //判断是否存在该资源地址
        } else if (resourcesService.selectCount(new EntityWrapper<Resources>().eq("resUrl", resUrl)) > 0) {
            map.put("flag", "resUrlIsExit");
        } else {
            Resources resources = new Resources();
            resources.setResName(resName);
            resources.setResUrl(resUrl);
            resources.setParentId(parentId);
            //判断是否为父级目录
            if (parentId == 0) {
                resources.setResLevel(0);
            } else {
                resources.setResLevel(1);
            }
            resourcesService.insert(resources);
            map.put("flag", "success");
        }
        return map;
    }
}
