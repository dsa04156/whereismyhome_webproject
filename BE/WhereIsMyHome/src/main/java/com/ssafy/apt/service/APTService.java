package com.ssafy.apt.service;

import java.util.ArrayList;
import java.util.List;

import com.ssafy.apt.model.APTDto;
import com.ssafy.apt.model.AvgAmoutDto;
import com.ssafy.apt.model.BookMarkDto;
import com.ssafy.apt.model.DealInfoDto;
import com.ssafy.apt.model.RankDto;
import com.ssafy.apt.model.SchoolDto;
import com.ssafy.apt.model.dongDto;

public interface APTService {
	public List<dongDto> searchsido() throws Exception;
	List<dongDto> searchgugun(String code) throws Exception;
	List<dongDto> searchdong(String code) throws Exception;
	List<APTDto> getList(String code) throws Exception;
	List<BookMarkDto> getBookMarkList(String id) throws Exception;
	int addBookMark(String id, String code) throws Exception;
	int deleteBookMark(String id, String code) throws Exception;
	List<APTDto> getAptList(String code) throws Exception;
	List<DealInfoDto> getDealList(String code, String pgNo) throws Exception;
	List<DealInfoDto> getDealAll(String code) throws Exception;
	int getDealSize(String code) throws Exception;
	List<SchoolDto> getSchoolList(String lng, String lat) throws Exception;
	List<AvgAmoutDto> getAvgAmoutList(String code) throws Exception;
	String getMaxAmount(String code) throws Exception;
	String getMinAmount(String code) throws Exception;
	List<RankDto> getRankList() throws Exception;
}
