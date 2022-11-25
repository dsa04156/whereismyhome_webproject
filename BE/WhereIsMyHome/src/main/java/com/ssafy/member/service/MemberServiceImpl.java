package com.ssafy.member.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.member.mapper.MemberMapper;
import com.ssafy.member.model.MemberDTO;

@Service
public class MemberServiceImpl implements MemberService {
	
	private MemberMapper mapper;
	
	@Autowired
	public MemberServiceImpl(MemberMapper mapper) {
		super();
		this.mapper = mapper;
	}

	@Override
	public MemberDTO login(MemberDTO memberDTO) throws Exception {
		return mapper.login(memberDTO);
	}

	@Override
	public int join(MemberDTO memberDTO) throws Exception {
		return mapper.join(memberDTO);
	}
	
	@Override
	public int editInfo(MemberDTO memberDTO) throws Exception {
		return mapper.editInfo(memberDTO);
	}
	
	@Override
	public int deleteInfo(String id) throws Exception {
		return mapper.deleteInfo(id);
	}

	@Override
	public String checkId(String id) throws Exception {
		return mapper.checkId(id);
	}

	@Override
	public void saveRefreshToken(String id, String refreshToken) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("token", refreshToken);
		mapper.saveRefreshToken(map);
	}

	@Override
	public MemberDTO getUserInfo(String id) throws Exception {
		return mapper.getUserInfo(id);
	}

	@Override
	public Object getRefreshToken(String id) throws Exception {
		return mapper.getRefreshToken(id);
	}

	@Override
	public void deleRefreshToken(String id) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("token", null);
		mapper.deleteRefreshToken(map);
		
	}

}
