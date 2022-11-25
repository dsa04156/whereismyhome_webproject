package com.ssafy.apt.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ssafy.apt.mapper.APTMapper;
import com.ssafy.apt.model.APTDto;
import com.ssafy.apt.model.AvgAmoutDto;
import com.ssafy.apt.model.BookMarkDto;
import com.ssafy.apt.model.DealInfoDto;
import com.ssafy.apt.model.RankDto;
import com.ssafy.apt.model.SchoolDto;
import com.ssafy.apt.model.dongDto;

@Service
@Transactional
public class APTServiceImpl implements APTService {
	
	private APTMapper mapper;
	
	@Autowired
	public APTServiceImpl(APTMapper mapper) {
		this.mapper = mapper;
	}

	@Override
	public List<dongDto> searchgugun(String code) throws Exception {
		return mapper.searchgugun(code);
	}

	@Override
	public List<dongDto> searchdong(String code) throws Exception {
		return mapper.searchdong(code);
	}

	@Override
	public List<APTDto> getList(String code) throws Exception {
		return mapper.getList(code);
	}

	@Override
	public List<BookMarkDto> getBookMarkList(String id) throws Exception {
		return mapper.getBookMarkList(id);
	}

	@Override
	public int addBookMark(String id, String code) throws Exception {
		return mapper.addBookMark(id, code);
	}

	@Override
	public int deleteBookMark(String id, String code) throws Exception {
		return mapper.deleteBookMark(id, code);
	}

	@Override
	public List<APTDto> getAptList(String code) throws Exception {
		return mapper.getAptList(code);
	}

	@Override
	public List<dongDto> searchsido() throws Exception {
		return mapper.searchsido();
	}

	private final static int LIST_SIZE = 10;
	
	@Override
	public List<DealInfoDto> getDealList(String code, String pgNo) throws Exception {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		int pgno = Integer.parseInt(pgNo == null ? "1" : pgNo);
		int start = pgno * LIST_SIZE - LIST_SIZE;
		map.put("start", start);
		map.put("listsize", LIST_SIZE);
		
		map.put("code", code);
		
		return mapper.getDealList(map);
	}

	@Override
	public List<DealInfoDto> getDealAll(String code) throws Exception {
		return mapper.getDealAll(code);
	}

	@Override
	public int getDealSize(String code) throws Exception {
		return mapper.getDealSize(code);
	}

	@Override
	public List<SchoolDto> getSchoolList(String lng, String lat) throws Exception {
		return mapper.getSchoolList(lng, lat);
	}

	@Override
	public List<AvgAmoutDto> getAvgAmoutList(String code) throws Exception {
		return mapper.getAvgAmoutList(code);
	}

	@Override
	public String getMaxAmount(String code) throws Exception {
		return mapper.getMaxAmount(code);
	}

	@Override
	public String getMinAmount(String code) throws Exception {
		return mapper.getMinAmount(code);
	}

	@Override
	public List<RankDto> getRankList() throws Exception {
		return mapper.getRankList();
	}
}
