IMAGE_TAG=swr.cn-north-4.myhuaweicloud.com/registry-huawei/effyic/skiff-ai-test:latest

if [ "$1" == "production" ]; then
  IMAGE_TAG=swr.cn-north-4.myhuaweicloud.com/registry-huawei/effyic/skiff-ai:latest
fi

docker build . --platform linux/amd64 -t $IMAGE_TAG
docker push $IMAGE_TAG