<#include "/java_copyright.include">
<#assign className = table.className>   
<#assign classNameLower = className?uncap_first>
package ${basepackage}.pojo; 

<#include "/java_imports.include">

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.io.Serializable;
import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
<#include "/java_description.include">
*/
@Repository
@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class ${className} implements Serializable{
	<#-- 日期类型的字段的格式化字符串定义 -->
	<#list table.columns as column>
		<#if column.isDateTimeColumn>
		public static final String FORMAT_${column.constantName} = DATE_FORMAT;
		</#if>
	</#list>
	<#-- 构造方法
	<@generateConstructor className/>
	 -->
	 <#-- 字段列表 -->
	<#list table.columns as column>
		<#-- //${column}-${column.columnName}-${column.javaType}-${column.unique?string("true","false")}-${column.pk?string("true","false")}-${column.constantName}-${column.columnAlias!}-${column.sqlName}-${column.columnNameLower} -->
		/**
		 * ${column.columnAlias!}
		 * DbColumnName:${column.sqlName} ${column.pk?string("pk","")} ${(!column.pk&column.unique)?string("unique","")}
		 */
		${column.hibernateValidatorExprssion}
		private ${column.javaType} ${column.columnNameLower};
	</#list>
	
		//日期字符串形式处理
	<#list table.columns as column>
		<#if column.isDateTimeColumn>
		public String get${column.columnName}String(){
			return new SimpleDateFormat(FORMAT_${column.constantName}).format(get${column.columnName});
		}
		public void set${column.columnName}String(String value) {
			set${column.columnName}(new SimpleDateFormat(FORMAT_${column.constantName}).parse(value));
		}
		</#if>
	</#list>

	public String toString() {
		return ToStringBuilder.reflectionToString(this,ToStringStyle.SHORT_PREFIX_STYLE);
	}
	public int hashCode() {
		return new HashCodeBuilder()
		<#list table.pkColumns as column>
			.append(get${column.columnName}())
		</#list>
			.toHashCode();
	}
	
	public boolean equals(Object obj) {
		if(obj instanceof ${className} == false) return false;
		if(this == obj) return true;
		${className} other = (${className})obj;
		return new EqualsBuilder()
			<#list table.pkColumns as column>
			.append(get${column.columnName}(),other.get${column.columnName}())
			</#list>
			.isEquals();
	}
<#if isPre>
${gg.generateFile("sqlMapping.xml","<typeAlias type=\"${basepackage}.pojo.${className}\" alias=\"${className}\" />\n",true)}
</#if>
<#-- 
${now?datetime}
${env.JAVA_HOME}
${gg.isIgnoreOutput()?string('true','false')}
${gg.generateFile("test.txt","hello")}
${gg.setIgnoreOutput(false)}
${gg.getProperty("namespace","namespace-not-found")}
${table.sqlName}
${table.remarks}
${table.tableAlias}
${className}
${table.idColumn.javaType}
${gg.getInputProperty("myKey")} -->