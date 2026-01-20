#!/bin/bash
# 로그 파일 경로 정의
LOG_FILE="/opt/codedeploy-agent/deployment-root/deployment-logs/codedeploy-agent-deployments.log"

# 1. 로그 디렉토리 및 파일 생성 (권한 부여)
sudo mkdir -p /opt/codedeploy-agent/deployment-root/deployment-logs/
sudo touch $LOG_FILE
sudo chmod 666 $LOG_FILE

# 2. 기존에 80번 포트 등에서 실행 중인 Streamlit 종료 (중복 실행 방지)
sudo pkill -f streamlit || true

# 3. Streamlit 실행 및 로그 저장
# - >> : 로그 파일에 내용 추가
# - 2>&1 : 에러(stderr)도 표준출력(stdout)과 함께 저장
# - & : 백그라운드 실행
echo "--- 배포 시작: $(date) ---" >> $LOG_FILE
sudo nohup /usr/bin/python3 /usr/local/bin/streamlit run /root/streamlit-project/main.py --server.port 80 >> $LOG_FILE 2>&1 &

echo "--- Streamlit 프로세스 실행 완료 ---" >> $LOG_FILE  