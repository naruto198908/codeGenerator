package cn.org.rapid_framework.generator.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import cn.org.rapid_framework.generator.GeneratorProperties;

public class KeepWords {
	private static Set<String> keepWords = new HashSet<String>();
	static {
		loadWordList("keep_words.txt", true);
		loadWordList("cn/org/rapid_framework/generator/util/keep_words.txt", false);
	}

	public static void loadWordList(String resourceName, boolean ignoreException) {
		try {
			InputStream input = GeneratorProperties.class.getClassLoader().getResourceAsStream(resourceName);
			keepWords.addAll(readLines(new InputStreamReader(input)));
			input.close();
		} catch (Exception e) {
			if (!ignoreException)
				throw new RuntimeException(e);
		}
	}

	public static List<String> readLines(Reader input) throws IOException {
		BufferedReader reader = new BufferedReader(input);
		List<String> list = new ArrayList<String>();
		String line = reader.readLine();
		while (line != null) {
			list.add(line.toLowerCase());// 转为小写
			line = reader.readLine();
		}
		return list;
	}

	/**
	 * 判断字符串中是否存在独立的单词
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isExistKeepWord(String str) {
		if (str == null) {
			return false;
		}
		for (int i = 0; i < str.length(); i++) {
			for (int j = i + 1; j < str.length(); j++) {
				String subStr = str.substring(i, j);
				if (keepWords.contains(subStr)) {
					return true;
				}
			}
		}
		return false;
	}

	/**
	 * 把字符串转成驼峰命名法
	 * @param str
	 * @return
	 */
	public static String convertTuoFeng(String str) {
		if (str == null) {
			return str;
		}
		str = str.toLowerCase();// 先全部转为小写。
		StringBuilder sb = new StringBuilder(str);
		sb.replace(0, 1, sb.substring(0, 1).toUpperCase());
		for (int i = 0; i < str.length(); i++) {
			for (int j = str.length() ; j > i; j--) {
				String subStr = str.substring(i, j);
//				System.out.println("i="+i+",j="+j+"="+subStr);
				if (keepWords.contains(subStr)) {
//					System.out.println(subStr);
					sb.replace(i, i+1, sb.substring(i,i+1).toUpperCase());
					i = j-1;
					break;
				}
			}
		}
		return sb.toString();
	}
}
