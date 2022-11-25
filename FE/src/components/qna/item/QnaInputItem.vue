<template>
    <b-row class="mb-1">
        <b-col style="text-align: left">
            <b-form @submit="onSubmit" @reset="onReset">
                <b-form-group id="userid-group" label="작성자:" label-for="name" description="작성자를 입력하세요.">
                    <b-form-input
                        id="name"
                        :disabled="isUserid"
                        v-model="qna.name"
                        type="text"
                        required
                        placeholder="작성자 입력..."
                    ></b-form-input>
                </b-form-group>

                <b-form-group id="subject-group" label="제목:" label-for="subject" description="제목을 입력하세요.">
                    <b-form-input
                        id="subject"
                        v-model="qna.subject"
                        type="text"
                        required
                        placeholder="제목 입력..."
                    ></b-form-input>
                </b-form-group>

                <b-form-group id="content-group" label="내용:" label-for="content">
                    <b-form-textarea
                        id="content"
                        v-model="qna.content"
                        placeholder="내용 입력..."
                        rows="10"
                        max-rows="15"
                    ></b-form-textarea>
                </b-form-group>

                <b-button type="submit" variant="primary" class="m-1" v-if="this.type === 'register'">글작성</b-button>
                <b-button type="submit" variant="primary" class="m-1" v-else>글수정</b-button>
                <b-button type="reset" variant="danger" class="m-1">초기화</b-button>
            </b-form>
        </b-col>
    </b-row>
</template>

<script>
import http from '@/api/http';

export default {
    name: 'QnaInputItem',
    data() {
        return {
            qna: {
                id: '',
                qnaNo: 0,
                name: '',
                subject: '',
                content: '',
            },
            isUserid: false,
        };
    },
    props: {
        type: { type: String },
    },
    created() {
        if (this.type === 'modify') {
            http.get(`/qna/${this.$route.params.qnaNo}`).then(({ data }) => {
                // this.qna.qnaNo = data.qna.qnaNo;
                // this.article.userid = data.article.userid;
                // this.article.subject = data.article.subject;
                // this.article.content = data.article.content;
                this.qna = data;
            });
            this.isUserid = true;
        }
    },
    methods: {
        onSubmit(event) {
            event.preventDefault();

            let err = true;
            let msg = '';
            // !this.qna.name && ((msg = "작성자 입력해주세요"), (err = false), this.$refs.name.focus());
            // err && !this.qna.subject && ((msg = "제목 입력해주세요"), (err = false), this.$refs.qna.focus());
            // err && !this.qna.content && ((msg = "내용 입력해주세요"), (err = false), this.$refs.qna.focus());

            console.log(this.type);
            if (!err) alert(msg);
            else this.type === 'register' ? this.registArticle() : this.modifyArticle();
        },
        onReset(event) {
            event.preventDefault();
            this.qna.qnaNo = 0;
            this.qna.subject = '';
            this.qna.content = '';
            this.moveList();
        },
        registArticle() {
            http.post('/qna/write', {
                id: this.qna.name,
                qnaNo: this.qna.id,
                subject: this.qna.subject,
                content: this.qna.content,
            }).then(({ data }) => {
                let msg = '등록 처리시 문제가 발생했습니다.';
                if (data === 'success') {
                    msg = '등록이 완료되었습니다.';
                }
                alert(msg);
                this.moveList();
            });
        },
        modifyArticle() {
            http.put(`/qna/${this.qna.qnaNo}/modify`, {
                qnaNo: this.qna.qnaNo,
                name: this.qna.name,
                pw: this.qna.pw,
                subject: this.qna.subject,
                content: this.qna.content,
            }).then(({ data }) => {
                let msg = '수정 처리시 문제가 발생했습니다.';
                if (data === 'success') {
                    msg = '수정이 완료되었습니다.';
                }
                alert(msg);
                // 현재 route를 /list로 변경.
                this.moveList();
            });
        },
        moveList() {
            this.$router.push({ name: 'qnalist' });
        },
    },
};
</script>

<style></style>
