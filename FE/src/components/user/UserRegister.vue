<template>
  <b-container class="bv-example-row">
    <div class="container h-100">
      <div class="row d-flex justify-content-center align-items-center h-100">
        <div class="col-12 col-md-9 col-lg-7 col-xl-6">
          <div class="card" style="border-radius: 15px">
            <div class="card-body p-5">
              <h2 class="text-uppercase text-center mb-5">회원 가입</h2>

              <form>
                <div class="form-outline mb-4 Check">
                  <label class="form-label Label" for="id">ID</label>

                  <input
                    type="text"
                    id="id"
                    name="id"
                    v-model="user.id"
                    class="form-control form-control-lg idc"
                  />
                  <b-button @click="CheckId">ID체크</b-button>
                </div>
                <div class="form-outline mb-4 Check">
                  <label class="form-label Label" for="name">Name</label>
                  <input
                    type="text"
                    id="name"
                    name="name"
                    v-model="user.name"
                    class="form-control form-control-lg inputText"
                  />
                </div>

                <div class="form-outline mb-4 Check">
                  <label class="form-label Label" for="email">전자 메일</label>
                  <input
                    type="email"
                    id="email"
                    name="email"
                    v-model="user.email"
                    class="form-control form-control-lg inputText"
                  />
                </div>

                <div class="form-outline mb-4 Check">
                  <label class="form-label Label" for="pw">비밀 번호</label>
                  <input
                    type="password"
                    id="pw"
                    name="pw"
                    v-model="user.pw"
                    class="form-control form-control-lg inputText"
                  />
                </div>
                <!-- <div class="form-outline mb-4">
                      <label class="form-label" for="comment">Comment</label>
                      <input
                        type="comment"
                        id="comment"
                        name="comment"
                        v-model="user.comment"
                        class="form-control form-control-lg"
                      />
                    </div> -->

                <div class="d-flex justify-content-center">
                  <button
                    id="joinBTN"
                    @click="submitForm"
                    class="btn btn-success btn-block btn-lg gradient-custom-4 text-white"
                  >
                    가입 하기
                  </button>

                  <!-- <a
                          type="button"
                          id="joinBTN"
                          @click="submitForm"
                          class="btn btn-success btn-block btn-lg gradient-custom-4 text-white"
                          >가입 하기</a
                        > -->
                </div>
                <!-- <button type="id" class="joinBTN" variant="primary" class="m-1">회원가입</button> -->

                <p class="text-center text-muted mt-5 mb-0">
                  이미 아이디가 있으신가요?
                  <b-button type="button" variant="danger" class="m-1"
                    >로그인</b-button
                  >
                  <!-- @click="movePage" -->
                </p>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </b-container>
</template>

<script>
import axios from "@/api/http";
// import axios from "@/api/index";
export default {
  name: "SignupForm",
  data() {
    return {
      user: {
        id: "",
        email: "",
        name: "",
        pw: "",
        level: "",
      },
    };
  },
  methods: {
    CheckId() {
      axios
        .get(`/user/checkId/${this.user.id}`)
        .then(({ data }) => {
          if (data == "success") alert("사용가능한 아이디 입니다.");
          else {
            alert("아이디 사용 불가");
            this.user.id = "";
          }
          console.log(data);
        })
        .catch((data) => {
          console.log(data);
        });
    },
    submitForm() {
      // axios
      //   .get("/user/join", { id: this.user.id })
      //   .then(({ data }) => {
      //     console.log(data);
      //   })
      //   .catch((data) => {
      //     console.log(data);
      //   });

      axios
        .post("/user/join", {
          id: this.user.id,
          pw: this.user.pw,
          email: this.user.email,
          name: this.user.name,
          level: "normal",
          withCredentials: true, // 쿠키 cors 통신 설정
        })
        .then(({ data }) => {
          console.log(data);
        })
        .catch((data) => {
          console.log(data);
        });

      this.$router.push({ name: "login" });
    },
  },
  movePage() {
    // this.$router.push({ name: 'login' });
  },
};
</script>

<style>
.idc {
  width: 190px;
  margin-left: 90px;
  justify-content: flex-end;
}
.inputText {
  width: auto;
}
.Check {
  display: flex;
  justify-content: space-between;
  text-align: center;
  vertical-align: middle;
}

.Label {
  margin-top: 15px;
}
</style>
