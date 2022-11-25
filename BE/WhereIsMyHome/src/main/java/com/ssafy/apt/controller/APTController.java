package com.ssafy.apt.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

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
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.ssafy.apt.model.APTDto;
import com.ssafy.apt.model.AvgAmoutDto;
import com.ssafy.apt.model.BookMarkDto;
import com.ssafy.apt.model.DealInfoDto;
import com.ssafy.apt.model.RankDto;
import com.ssafy.apt.model.SchoolDto;
import com.ssafy.apt.model.dongDto;
import com.ssafy.apt.service.APTService;
import com.ssafy.apt.service.APTServiceImpl;
import com.ssafy.member.model.MemberDTO;
import com.ssafy.notice.model.NoticeDTO;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

@RestController
@RequestMapping("/apt")
@CrossOrigin("*")
@Api("아파트 컨트롤러  API V1")
public class APTController {

	private static final Logger logger = LoggerFactory.getLogger(APTController.class);

	private static final String SUCCESS = "success";
	private static final String FAIL = "fail";

	private APTService service;

	@Autowired
	public APTController(APTService service) {
		this.service = service;
	}

	@ApiOperation(value = "시도 정보 리스트 반환", notes = "시도 정보 반환한다.", response = List.class)
	@GetMapping("/sido")
	private ResponseEntity<?> searchSido() throws Exception {

		logger.info("searchSido - 호출");

		return new ResponseEntity<List<dongDto>>(service.searchsido(), HttpStatus.OK);
	}

	@ApiOperation(value = "구군 정보 리스트 반환", notes = "조회할 시도 코드를 입력한다.", response = List.class)
	@GetMapping("/gugun")
	private ResponseEntity<?> searchGugun(@RequestParam("sido") String code) throws Exception {

		logger.info("searchGugun - 호출");

		return new ResponseEntity<List<dongDto>>(service.searchgugun(code), HttpStatus.OK);
	}

	@ApiOperation(value = "동 정보 리스트 반환", notes = "조회할 구군 코드를 입력한다.", response = List.class)
	@GetMapping("/dong")
	private ResponseEntity<?> searchDong(@RequestParam("gugun") String code) throws Exception {

		logger.info("searchDong - 호출");

		return new ResponseEntity<List<dongDto>>(service.searchdong(code), HttpStatus.OK);
	}

	@ApiOperation(value = "아파트 정보 리스트 반환", notes = "조회할 코드를 입력한다.", response = List.class)
	@GetMapping("/list")
	private ResponseEntity<?> getList(@RequestParam("dong") String code) throws Exception {

		logger.info("getList - 호출");

		return new ResponseEntity<List<APTDto>>(service.getList(code), HttpStatus.OK);
	}

	@ApiOperation(value = "아파트 거래 정보 리스트 반환", notes = "조회할 아파트 코드를 입력한다.", response = List.class)
	@GetMapping("/dealList/{aptCode}")
	private ResponseEntity<?> getDealAll(@PathVariable("aptCode") String code) throws Exception {

		logger.info("getDealList - 호출");

		return new ResponseEntity<List<DealInfoDto>>(service.getDealAll(code), HttpStatus.OK);
	}

	@ApiOperation(value = "아파트 거래 정보 사이즈 반환", notes = "조회할 아파트 코드를 입력한다.", response = Integer.class)
	@GetMapping("/dealListSize/{aptCode}")
	private ResponseEntity<?> getDealSize(@PathVariable("aptCode") String code) throws Exception {

		logger.info("getDealList - 호출");

		return new ResponseEntity<Integer>(service.getDealSize(code), HttpStatus.OK);
	}

	@ApiOperation(value = "아파트 거래 정보 리스트 반환", notes = "조회할 아파트 코드를 입력한다.", response = List.class)
	@GetMapping("/dealList/{aptCode}/{pgNo}")
	private ResponseEntity<?> getDealList(@PathVariable("aptCode") String code, @PathVariable("pgNo") String pgNo)
			throws Exception {

		logger.info("getDealList - 호출");

		return new ResponseEntity<List<DealInfoDto>>(service.getDealList(code, pgNo), HttpStatus.OK);
	}

	@ApiOperation(value = "주변 학군 리스트 반환", notes = "조회할 아파트 코드를 입력한다.", response = List.class)
	@GetMapping("/schoolList")
	private ResponseEntity<?> getSchoolList(@RequestParam String lng, @RequestParam String lat) throws Exception {

		logger.info("getSchoolList - 호출");

		return new ResponseEntity<List<SchoolDto>>(service.getSchoolList(lng, lat), HttpStatus.OK);
	}
	
	@ApiOperation(value = "사용자별 북마크 리스트 반환", notes = "조회할 사용자 아이디를 입력한다.", response = List.class)
	@GetMapping("/bookmark/{id}")
	public ResponseEntity<?> bookmarkList(@PathVariable("id") String id) throws Exception {

		logger.info("bookmarkList - 호출");

		return new ResponseEntity<List<BookMarkDto>>(service.getBookMarkList(id), HttpStatus.OK);
	}

	@ApiOperation(value = "북마크 아파트 리스트 반환", notes = "조회할 지역번호를 입력한다.", response = List.class)
	@GetMapping("/bookmarklist/{code}")
	private ResponseEntity<?> getbookmarkList(@PathVariable("code") String code) throws Exception {

		logger.info("getbookmarkList - 호출");

		return new ResponseEntity<List<APTDto>>(service.getAptList(code), HttpStatus.OK);
	}

	@ApiOperation(value = "북마크 추가", notes = "추가할 지역번호를 입력한다. 그리고 DB수정 성공여부에 따라 'success' 또는 'fail' 문자열을 반환한다.", response = String.class)
	@PostMapping("/addBookMark")
	private ResponseEntity<String> addBookMark(@RequestParam String id, @RequestParam String code)
			throws Exception {

		logger.info("addBookMark - 호출");

		if (service.addBookMark(id, code) != 0)
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		return new ResponseEntity<String>(FAIL, HttpStatus.OK);
	}

	@ApiOperation(value = "북마크 삭제", notes = "삭제할 지역번호를 입력한다. 그리고 DB수정 성공여부에 따라 'success' 또는 'fail' 문자열을 반환한다.", response = String.class)
	@DeleteMapping("/deleteBookMark")
	private ResponseEntity<?> deleteBookMark(@RequestParam String id, @RequestParam String code)
			throws Exception {

		logger.info("deleteBookMark - 호출");

		if (service.deleteBookMark(id, code) != 0)
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		return new ResponseEntity<String>(FAIL, HttpStatus.OK);
	}
	
	@ApiOperation(value = "아파트 평균 매매가", notes = "조회할 아파트 코드를 입력한다.", response = List.class)
	@GetMapping("/aptAvg/{aptCode}")
	private ResponseEntity<?> getAvgAmout(@PathVariable("aptCode") String code) throws Exception {

		logger.info("getAvgAmout - 호출");

		return new ResponseEntity<List<AvgAmoutDto>>(service.getAvgAmoutList(code), HttpStatus.OK);
	}
	
	@ApiOperation(value = "아파트 매매가 최대값", notes = "조회할 아파트 코드를 입력한다.", response = String.class)
	@GetMapping("/AvgMax/{aptCode}")
	private ResponseEntity<?> getMaxAmount(@PathVariable("aptCode") String code) throws Exception {

		logger.info("getMaxAmount - 호출");

		return new ResponseEntity<String>(service.getMaxAmount(code), HttpStatus.OK);
	}
	
	@ApiOperation(value = "아파트 매매가 최소값", notes = "조회할 아파트 코드를 입력한다.", response = String.class)
	@GetMapping("/AvgMin/{aptCode}")
	private ResponseEntity<?> getMinAmount(@PathVariable("aptCode") String code) throws Exception {

		logger.info("getMinAmount - 호출");

		return new ResponseEntity<String>(service.getMinAmount(code), HttpStatus.OK);
	}
	
	@ApiOperation(value = "관심지역 순위", notes = "관심지역 순위를 출력한다", response = List.class)
	@GetMapping("/rank")
	private ResponseEntity<?> getRankList() throws Exception {

		logger.info("getRankList - 호출");

		return new ResponseEntity<List<RankDto>>(service.getRankList(), HttpStatus.OK);
	}

	private ResponseEntity<String> exceptionHandling(Exception e) {
		e.printStackTrace();
		return new ResponseEntity<String>("Error : " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
