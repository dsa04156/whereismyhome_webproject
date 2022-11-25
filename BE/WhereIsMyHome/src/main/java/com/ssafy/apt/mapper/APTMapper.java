package com.ssafy.apt.mapper;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ssafy.apt.model.APTDto;
import com.ssafy.apt.model.AvgAmoutDto;
import com.ssafy.apt.model.BookMarkDto;
import com.ssafy.apt.model.DealInfoDto;
import com.ssafy.apt.model.RankDto;
import com.ssafy.apt.model.SchoolDto;
import com.ssafy.apt.model.dongDto;

@Repository
@Mapper
public interface APTMapper {
	public List<dongDto> searchsido();
	public List<dongDto> searchgugun(String code);
	public List<dongDto> searchdong(String code);
	List<APTDto> getList(String code);
	List<BookMarkDto> getBookMarkList(String id);
	int addBookMark(String id, String code);
	int deleteBookMark(String id, String code);
	List<APTDto> getAptList(String code);
	List<DealInfoDto> getDealList(HashMap<String, Object> map);
	List<DealInfoDto> getDealAll(String code);
	int getDealSize(String code);
	List<SchoolDto> getSchoolList(String lng, String lat);
	List<AvgAmoutDto> getAvgAmoutList(String code);
	String getMaxAmount(String code);
	String getMinAmount(String code);
	List<RankDto> getRankList();
}
