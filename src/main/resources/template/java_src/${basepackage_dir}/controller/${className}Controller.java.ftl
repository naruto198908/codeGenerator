<#assign className = table.className>   
<#assign classNameLower = className?uncap_first>
<#include "/java_copyright.include">
package ${basepackage}.controller; 

<#include "java_imports.include">
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.ui.ModelMap;
import ${basepackage}.pojo.${className};
import ${basepackage}.service.${className}Service;
import ${basepackage}.mapper.${className}Mapper;

/**
 * ${className}Controller
 */
@Controller
@RequestMapper("/xxx/${classNameLower}");
public class ${className}Controller extends BaseController{

	@Autowired
	private ${className}Service ${classNameLower}Service;
	
	<#list table.columns as column>
		<#if column.unique>
	/**
	 * 根据${column.columnNameLower}查询${className}
	 */
	public ${className} queryBy${column.columnName}(${column.javaType} ${column.columnNameLower}){
		return ${classNameLower}Service.queryBy${column.columnName}(${column.columnNameLower});
	}
	
	
		</#if>
	</#list>
	
	/**
	 * 分页、条件、排序查询${className}
	 */
	 @RequestMapping("list")
	public String queryList(${className} ${classNameLower}, ModelMap modelMap){
		modelMap.put("result",${classNameLower}Service.queryList(${classNameLower}));
		modelMap.put("model",${classNameLower});
		return "${namespace_dir}/${classNameLower}/list";
	}
	
	/**
	 * 添加${className}
	 */
    @RequestMapping("add")
	public ModelAndView save(@Valid ${className} ${classNameLower}, BindingResult bResult){
        ControllerUtils.validateExclude(bResult, "${table.pkColumn.columnNameLower}");
		${classNameLower}Service.save(${classNameLower});
        return ControllerUtils.ajaxSuccess("添加成功");
	}
	
	/**
	 * 更新${className}
	 */
	public ModelAndView update(@Valid ${className} ${classNameLower}, BindingResult bResult){
        ControllerUtils.validateAll(bResult);
		${classNameLower}Service.update(${classNameLower});
        return ControllerUtils.ajaxSuccess("修改成功");
	}
	
	/**
	 * 根据${table.pkColumn.columnNameLower}删除${table.pkColumn.columnName}
	 */
    @RequestMapping("delete")
	public void deleteBy${table.pkColumn.columnName}(@RequestParam("${table.pkColumn.columnNameLower}")  ${table.pkColumn.javaType} ${table.pkColumn.columnNameLower}){
		${table.pkColumn.columnNameLower}Service.deleteBy${table.pkColumn.columnName}(${table.pkColumn.columnNameLower});
	}
	/**
	 * 进入编辑页
	 */
    @RequestMapping("edit/{${table.pkColumn.columnNameLower}}")
    public String edit(@PathVariable("${table.pkColumn.columnNameLower}") ${table.pkColumn.javaType} ${table.pkColumn.columnNameLower}, ModelMap modelMap)
    {
        ${className} ${classNameLower} = ${table.pkColumn.columnNameLower}Service.queryBy${table.pkColumn.columnName}(${table.pkColumn.columnNameLower});
        modelMap.put("model", ${classNameLower});
        return "${namespace_dir}/${classNameLower}/edit";
    }
    
    @RequestMapping("detail/{${table.pkColumn.columnNameLower}}")
    public String detail(@PathVariable("${table.pkColumn.columnNameLower}") ${table.pkColumn.javaType} ${table.pkColumn.columnNameLower}, ModelMap modelMap) throws BusinessException
    {
        ${className} ${classNameLower} = ${table.pkColumn.columnNameLower}Service.queryBy${table.pkColumn.columnName}(${table.pkColumn.columnNameLower});
        modelMap.put("result", ${classNameLower});
        return "${namespace_dir}/${classNameLower}/detail";
    }
}