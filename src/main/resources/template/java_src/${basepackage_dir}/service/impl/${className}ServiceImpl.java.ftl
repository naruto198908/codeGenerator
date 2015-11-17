<#assign className = table.className>   
<#assign classNameLower = className?uncap_first>
<#include "/java_copyright.include">
package ${basepackage}.service.impl; 

<#include "java_imports.include">
import org.springframework.stereotype.Service;
import ${basepackage}.pojo.${className};
import ${basepackage}.service.${className}Service;
import ${basepackage}.mapper.${className}Mapper;

/**
 * ${className}ServiceImpl
 */
@Service
public class ${className}ServiceImpl impletement ${className}Service{

	@Autowired
	private ${className}Mapper ${classNameLower}Mapper;
	
	<#list table.columns as column>
		<#if column.unique>
	/**
	 * 根据${column.columnNameLower}查询${className}
	 */
	public ${className} queryBy${column.columnName}(${column.javaType} ${column.columnNameLower}){
		return ${classNameLower}Mapper.queryBy${column.columnName}(${column.columnNameLower});
	}
	
	/**
	 * 根据${column.columnNameLower}删除${className}
	 */
	public void deleteBy${column.columnName}(${column.javaType} ${column.columnNameLower}){
		${classNameLower}Mapper.deleteBy${column.columnName}(${column.columnNameLower});
	}
	
		</#if>
	</#list>
	
	/**
	 * 分页、条件、排序查询${className}
	 */
	public List<${className}> queryList(${className} ${classNameLower}){
		long count = ${classNameLower}Mapper.countForQueryList(${classNameLower});
		${classNameLower}.setTotalCount(count);
		return ${classNameLower}Mapper.queryList(${classNameLower});
	}
	
	/**
	 * 添加${className}
	 */
	public void save(${className} ${classNameLower}){
		${classNameLower}Mapper.save(${classNameLower});
	}
	
	/**
	 * 更新${className}
	 */
	public void update(${className} ${classNameLower}){
		${classNameLower}Mapper.update(${classNameLower});
	}
	
}