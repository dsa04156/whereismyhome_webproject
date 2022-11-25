package com.ssafy.notice.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.ssafy.apt.model.BookMarkDto;
import com.ssafy.member.model.MemberDTO;
import com.ssafy.notice.model.NoticeDTO;
import com.ssafy.notice.service.NoticeService;
import com.ssafy.notice.service.NoticeServiceImpl;
import com.ssafy.qna.model.QnaDTO;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;

//http://localhost:80//swagger-ui/
@RestController
@RequestMapping("/notice")
@Api("공지사항 컨트롤러  API V1")
public class NoticeController {

	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);

	private static final String SUCCESS = "success";
	private static final String FAIL = "fail";

	private NoticeService noticeService;

	@Autowired
	public NoticeController(NoticeService noticeService) {
		super();
		this.noticeService = noticeService;
	}

	static int articleNo;

	@ApiOperation(value = "공지사항 글목록", notes = "모든 게시글의 정보를 반환한다.", response = List.class)
	@GetMapping("")
	public ResponseEntity<?> noticeList() throws Exception {

		System.out.println("list hi");

		return new ResponseEntity<List<NoticeDTO>>(noticeService.listArticle(), HttpStatus.OK);
	}

	@ApiOperation(value = "공지사항 글작성", notes = "새로운 공지사항 정보를 입력한다. 그리고 DB입력 성공여부에 따라 'success' 또는 'fail' 문자열을 반환한다.", response = String.class)
	@PostMapping("/write")
	public ResponseEntity<String> writeNotice(
			@RequestBody @ApiParam(value = "공지사항 정보.", required = true) NoticeDTO noticeDto) throws Exception {
		logger.info("wirteQna - 호출");

		if (noticeService.writeArticle(noticeDto) != 0) {
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		} else
			return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
	}

	@ApiOperation(value = "공지사항 글보기", notes = "글번호에 해당하는 공지사항 정보를 반환한다.", response = NoticeDTO.class)
	@GetMapping("/{articleNo}")
	public ResponseEntity<?> noticeInfo(@PathVariable("articleNo") int articleNo) throws Exception {

		System.out.println("info hi");
		noticeService.updateHit(articleNo);
		return new ResponseEntity<NoticeDTO>(noticeService.getArticle(articleNo), HttpStatus.OK);
	}

	@ApiOperation(value = "공지사항 글수정", notes = "수정할 공지사항 정보를 입력한다. 그리고 DB수정 성공여부에 따라 'success' 또는 'fail' 문자열을 반환한다.", response = String.class)
	@PutMapping("/{articleNo}/modify")
	public ResponseEntity<String> modifyNotice(
			@RequestBody @ApiParam(value = "수정할 글정보.", required = true) NoticeDTO noticeDto) throws Exception {
		logger.info("modifyNotice - 호출 {}", noticeDto);

		if (noticeService.modifyArticle(noticeDto) != 0) {
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		}
		return new ResponseEntity<String>(FAIL, HttpStatus.OK);
	}

	@ApiOperation(value = "공지사항 글삭제", notes = "글번호에 해당하는 공지사항 정보를 삭제한다. 그리고 DB삭제 성공여부에 따라 'success' 또는 'fail' 문자열을 반환한다.", response = String.class)
	@DeleteMapping("/{articleNo}/delete")
	public ResponseEntity<String> deleteNotice(
			@PathVariable("articleNo") @ApiParam(value = "살제할 글의 글번호.", required = true) int articleNo)
			throws Exception {
		logger.info("deleteNotice - 호출");
		if (noticeService.deleteArticle(articleNo) != 0) {
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		}
		return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
	}

	private ResponseEntity<String> exceptionHandling(Exception e) {
		e.printStackTrace();
		return new ResponseEntity<String>("Error : " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
	}

}
