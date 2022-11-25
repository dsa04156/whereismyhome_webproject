<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Spinner Start -->
    <div id="spinner"
        class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
        <div class="spinner-grow text-primary" role="status"></div>
    </div>
    <!-- Spinner End -->


    <!-- Navbar Start -->
    <div class="container-fluid fixed-top px-0 wow fadeIn" data-wow-delay="0.1s">
 				<c:if test="${userInfo eq null}">
 				<div class="top-bar text-white-50 row gx-0 align-items-center d-none d-lg-flex">
                <div class="col-3 col-sm-6 col-lg-9">
                </div>
                <div class="col-9 col-sm-6 col-lg-3">
                    <div id="header-top-second" class="clearfix">
                        <div class="btn-group">
                            <a href="/member/mvjoin" class="btn btn-default btn-sm"><i class="fa fa-user pr-2"></i> Sign
                                Up</a>
                        </div>

                        <div class="btn-group">
                            <!-- Button trigger modal -->
                            <button type="button" class="btn btn-default btn-sm" data-bs-toggle="modal"
                                data-bs-target="#exampleModal">
                                <i class="fa fa-lock pr-2"></i> Login
                            </button>

                            <!-- Modal -->
                            <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel"
                                aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-body">
                                            
                                            <section>
                                                <div class="container">
                                                    <div class="card bg-dark text-white" style="border-radius: 1rem;">
                                                        <div class="card-body p-5 text-center">
                                    
                                                            <div class="">
															<form method="post" action="/member/login">
																<input type="hidden" name="act" value="login">
																<h2 class="fw-bold text-white mb-2 text-uppercase">Login</h2>
																<p class="text-white-50 mb-5">Please enter your
																	login and password!</p>

																<div class="form-outline form-white mb-4">
																	<label class="form-label" for="id">ID</label> 
																	<input type="text" id="nid" name="id"
																		class="form-control form-control-lg" />
																</div>

																<div class="form-outline form-white mb-4">
																	<label class="form-label" for="password">Password</label>
																	<input type="password" id="password" name="pw"
																		class="form-control form-control-lg" />
																</div>
																<button class="btn btn-outline-light btn-lg px-5"
																	type="submit">Login</button>
															</form>

														</div>
                                    
                                                            <div class="pt-5">
                                                                <p class="mb-0">Don't have an account? <a href="${root}/member?act=mvregist" class="text-white-50 fw-bold">Sign
                                                                        Up</a>
                                                                </p>
                                                            </div>
                                    
                                                        </div>
                                                    </div>
                                                </div>
                                            </section>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            </c:if>

        <c:if test="${userInfo ne null }">
            <div class="top-bar text-white-50 row gx-0 align-items-center d-none d-lg-flex" style="display: none;">
                <div class="col-3 col-sm-6 col-lg-9">
                </div>
                <div class="col-9 col-sm-6 col-lg-3">
                    <div id="header-top-second" class="clearfix">
                        <div class="btn-group">
                            <a href="/member/logout" class="btn btn-default btn-sm" id="logoutBtn"><i class="fa fa-user pr-2"></i> LogOut</a>
                        </div>
                        <div class="btn-group">
                            <button id="header-top-drop-2" type="button"
                                class="btn dropdown-toggle btn-default btn-sm dropdown-toggle--no-caret"
                                data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fa fa-lock pr-2"></i> 마이 페이지
                            </button>
                            <ul class="dropdown-menu bg-dark" aria-labelledby="dropdownMenu2">
                                <li><button class="dropdown-item text-white" type="button" id="mypageMove" onclick="location.href='/member/mypage'">내 정보 페이지</button></li>
                                <li><button class="dropdown-item text-white" type="button" onclick="location.href='/bookmark'">관심지역 보기</button></li>
                                <c:if test="${userInfo.level eq 'admin' }">
                                <li><button class="dropdown-item text-white" type="button" onclick="location.href='sign_upForAdmin.jsp'">관리자 계정 추가</button></li>                                
                                </c:if>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>

        <nav class="navbar navbar-expand-lg navbar-dark py-lg-0 px-lg-5 wow fadeIn" data-wow-delay="0.1s">
           <!-- <a href="${root}/index.jsp" class="navbar-brand ms-4 ms-lg-0"> -->
            <a href="/" class="navbar-brand ms-4 ms-lg-0">
                <h1 class="fw-bold text-primary m-0">Where <span class="text-white">Is My </span>
                    <Home class="text-success">Home</span>
                </h1>
            </a>
            <button type="button" class="navbar-toggler me-4" data-bs-toggle="collapse"
                data-bs-target="#navbarCollapse">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarCollapse">
                <div class="navbar-nav ms-auto p-4 p-lg-0">
                    <a href="/" class="nav-item nav-link active">Home</a>
                    <a href="/notice" class="nav-item nav-link">공지 사항</a>
                    <a href="/mvQnA" class="nav-item nav-link">Q&A</a>
                    <a href="${root}/news.jsp" class="nav-item nav-link">오늘의 뉴스</a>
                </div>
            </div>
        </nav>
    </div>
    <!-- Navbar End -->
    