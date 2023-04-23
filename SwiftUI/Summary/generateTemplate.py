import sys
import os
import subprocess 

# subprocess 모듈은 새로운 프로세스를 생성하고, 그들의 입력/출력/에러 파이프에 연결하고, 반환 코드를 얻을 수 있도록 합니다. 이 모듈은 몇 가지 이전 모듈과 함수를 대체하려고 합니다:
'''
subprocess.run(
 args, *,  실행될 명령어와 문자열을 공백 문자 기준으로 나눈 문자열 리스트 (실행될 명령어와 필요한 인자들이 들어있음)
 stdin=None,  표준 입력 리다이렉션 
 input=None,  표준입력을 전달,기본적으로 바이트 스트림이지만 ,encoding 옵션이나 text = True로 전달하면 문자열이 전달됨
 stdout=None, 서브 프로세스에서 캡쳐된 표준 출력 내용
 stderr=None, 표준 에러 리다이렉션
 capture_output=False, 표준출력과 표준에러를 캡쳐한다. 명령어를 실행하고 결과 값을 가져오는 check_output()을 대신 쓸 수 있다. 
 shell=False, 별도의 서브 쉘을 실행한다. shell = True 일 경우 args는 리스트 형태가아닌 문자열 형태로 쓰는 것이 좋다.
 cwd=None,  
 timeout=None, 
 check=False, 비정상 종료 시 CalledProcessError를 발생시킬지 여부
 encoding=None, 
 errors=None, 
 text=None, 
 env=None, 서브 프로세스의 환경 변수를 정희하는 맵핑
 universal_newlines=None, 
 **other_popen_kwargs)
'''


def make_dir(path):
    if not os.path.exists(path):
        os.makedirs(path)

def make_markdown(file_path,codes):
    markdown_file_path = f"{file_path}/README.md"

    if not os.path.isfile(markdown_file_path):
        subprocess.run(['touch', markdown_file_path]) # filepath 생성하기

    master_key_file = open(markdown_file_path, 'w')
    master_key_file.write(codes)
    master_key_file.close()

def make_lecture(lecture_name:str):
    make_dir(lecture_name)
    make_markdown(lecture_name,"Tmp")



print('Input new lecture name ', end=': ', flush=True)

lecture_name = sys.stdin.readline().replace("\n", "")

print(f'Start to generate the new lecutre named {lecture_name}...')

current_file_path = os.path.dirname(os.path.abspath(__file__))

os.chdir(current_file_path) # 디렉토리 변경
#os.chdir(os.pardir) # 부모 디렉토리 설정

make_lecture(lecture_name=lecture_name)
