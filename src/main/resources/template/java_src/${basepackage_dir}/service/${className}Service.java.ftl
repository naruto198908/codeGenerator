<#assign className = table.className>   
<#assign classNameLower = className?uncap_first>
<#include "/java_copyright.include">
package ${basepackage}.service; 

<#include "java_imports.include">
import org.springframework.stereotype.Repository;
import ${basepackage}.pojo.${className};

/**
 * ${className}Service
 */
@Repository
public interface ${className}Service {

	<#list table.columns as column>
		<#if column.unique>
	/**
	 * 根据${column.columnNameLower}查询${className}
	 */
	public ${className} queryBy${column.columnName}(${column.javaType} ${column.columnNameLower});
	
	/**
	 * 根据${column.columnNameLower}删除${className}
	 */
	public void deleteBy${column.columnName}(${column.javaType} ${column.columnNameLower});
	
		</#if>
	</#list>
	
	/**
	 * 分页、条件、排序查询${className}
	 */
	public List<${className}> queryList(${className} ${classNameLower});
	
	/**
	 * 添加${className}
	 */
	public void save(${className} ${classNameLower});
	
	/**
	 * 更新${className}
	 */
	public void update(${className} ${classNameLower});
	
}