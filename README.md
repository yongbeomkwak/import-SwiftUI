# Apple Developer Academy  Tech & Design Study 규칙

<br><br>

### 커밋 규칙
- 가장 작은 단위로 많은 커밋을 푸쉬하는 것을 목표로합니다
- 커밋의 단위가 크면 나중에 PR시 한 커밋에 여러개의 변화를 확인해야하는 불편함이 있습니다.
- ex) 함수 lecture를  작은 단위 작성이 완료되면 바로 커밋 후 푸쉬를 권장합니다.
  1. 기본함수 정의 방법 작성
  2. 매개 변수가 없는 함수 
  3. 리턴값이 없는 함수 등  
- 소스코드를 첨부하고 싶은 경우 Source폴더를 만든 후 해당 파일이름을 관련 있는 네이밍으로 짓는다.
  - ex) Source/매개변수 없는 함수.swift , Source/inout.swift

<br><br>

### *커밋 메시지 템플릿*

<table align = "center">
 
 <th> Emoji  </th>
 <th> Emoji Name </th>
 <th> Description</th>
 <th> Example </th>
 
 <tr>
   <td align = "center"> :tada: </td>
   <td align = "center"> : tada : </td>
    <td align = "center"> 새로운 lecture 생성 </td>
     <td align = "left"> :tada: :: 함수 강의 lecture 생성 </td>
 </tr>
 
  <tr>
   <td align = "center"> 📄 </td>
   <td align = "center"> : page_facing_up : </td>
    <td align = "center"> lecture의 첫 Readme 추가 </td>
     <td align = "left"> 📄 :: 함수 lecture 첫 Readme 추가 </td>
 </tr>
 
 
  <tr>
   <td align = "center"> ✏️ </td>
   <td align = "center"> : pencil : </td>
    <td align = "center"> Readme 내용 추가 </td>
     <td align = "left"> ✏️ :: 함수 lecture 내용 추가 </td>
 </tr>
 
 
  <tr>
   <td align = "center"> 🛠️ </td>
   <td align = "center"> :hammer_wrench: </td>
    <td align = "center"> 잘못된 Readme 수정 </td>
     <td align = "left"> 🛠️ :: 함수 lecture Readme 수정 </td>
 </tr>
 
 <tr>
   <td align = "center"> 🖼️ </td>
   <td align = "center"> :frame_photo: </td>
    <td align = "center"> 시작적인 자료 업로드 </td>
     <td align = "left"> 🖼️ :: 참조타입에 대한 시각 자료 업로드 </td>
 </tr>
 
 
  <tr>
   <td align = "center"> 👏 </td>
   <td align = "center"> : clap : </td>
    <td align = "center">  병합(merge) </td>
     <td align = "left"> 👏 :: 함수 lecture 정리 완료 </td>
 </tr>
 
 <tr>
   <td align = "center"> 📎 </td>
   <td align = "center"> : paperclip : </td>
    <td align = "center">  소스 코드 첨부 </td>
     <td align = "left"> 📎 :: 함수 lecture 소스 코드 첨부 </td>
 </tr>


</table>

<br><br>

## 브랜치 규칙 

1. 브랜치 명
 - **브랜치를 만들기 전 반드시 다른 인원이 해당 lecture 작업을 하고 있는 지 확인한다.**
 - _절대 main 브랜치는 건드리지 않는다._
 - lecture/강의명_닉네임 으로 만.
   -  ex) lecture/function_Kayle 
   

<br>

2. PR 규칙
 - 브랜치를 합칠 때는 반드시 PR을 작성해서 올립니다.
 - PR은 아직 정확한 템플릿은 없지만 잘 써주시는 분 PR 방식을 템플릿으로 채택할 생각입니다.
 - PR은 최소 2명이상의 approve를 받아야 승인 할 수 있습니다.
 - 만약 approve를 받지 못했다면 반드시 해당 사항에대하여 고쳐주시길 바랍니다.
 - 만약 해당 PR에 대하여 approve가 아닌 과정을 했을 시 반드시 정확한 피드백(코멘트)를 해주시기 바랍니다.

<br>

## 참고 자료
[리드미 문법 참고 자료](https://gist.github.com/ihoneymon/652be052a0727ad59601)
