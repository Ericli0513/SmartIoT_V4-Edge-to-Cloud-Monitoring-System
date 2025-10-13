import boto3
import time
from decimal import Decimal

dynamodb = boto3.resource('dynamodb')
quota_table = dynamodb.Table('DeviceQuota')
ses = boto3.client('ses', region_name='ap-northeast-1')

MAX_SEND_ROUNDS = 3
DANGER_THRESHOLD = 40

def lambda_handler(event, context):
    print("🚀 Lambda 啟動，收到事件:", event)

     # '''

        # Step 2: 嘗試寄信
        success_count = 0
        for email in RECIPIENTS:
            try:
                ses.send_email(
                    Source=SENDER,
                    Destination={'ToAddresses': [email]},
                    Message={
                        'Subject': {'Data': f'Danger Alert: {device_id}'},
                        'Body': {'Text': {'Data': f"""⚠️ 危險警告通知\n\n裝置 ID：{device_id}\n危險指數：{danger_index:.2f}\n時間：{timestamp}\n\n請儘速確認裝置狀況。"""}}
                    }
                )
                print(f"[INFO] ✅ 警報信已寄出給: {email}")
                success_count += 1
                time.sleep(1)
            except Exception as e:
                print(f"[ERROR] ❌ 寄信失敗給: {email}, 錯誤: {e}")

         # '''
    print("✅ Lambda 執行完成")
    return {'statusCode': 200, 'body': '處理完成'}
