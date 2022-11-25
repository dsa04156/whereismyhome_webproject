package com.ssafy.notice.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.notice.mapper.NoticeMapper;
import com.ssafy.notice.model.NoticeDTO;
import com.ssafy.notice.service.NoticeService;

@Service
public class NoticeServiceImpl implements NoticeService {

	private NoticeMapper mapper;

	@Autowired
	public NoticeServiceImpl(NoticeMapper mapper) {
		super();
		this.mapper = mapper;
	}

	@Override
	public int writeArticle(NoticeDTO noticeDTO) throws Exception {
		return mapper.writeArticle(noticeDTO);
	}

	@Override
	public List<NoticeDTO> listArticle() throws Exception {
		return mapper.listArticle();
	}

	@Override
	public NoticeDTO getArticle(int articleNo) throws Exception {
		return mapper.getArticle(articleNo);
	}

	@Override
	public int modifyArticle(NoticeDTO noticeDTO) throws Exception {
		return mapper.modifyArticle(noticeDTO);
	}

	@Override
	public int deleteArticle(int articleNo) throws Exception {
		return mapper.deleteArticle(articleNo);
	}

	@Override
	public int updateHit(int articleNo) throws Exception {
		return mapper.updateHit(articleNo);
	}

}
