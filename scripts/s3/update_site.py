import boto3

BUCKET_NAME = 'aws-petrisor-bucket'
s3 = boto3.client('s3')
def upload():
    with open('index.html', 'rb') as f:
        s3.put_object(Bucket=BUCKET_NAME, Key='index.html', Body=f, ContentType='text/html')
    print('Site updated!')
if __name__ == '__main__':
    upload()
