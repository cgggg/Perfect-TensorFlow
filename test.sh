# This script is for CI Server
echo 'Clean Temp Files'
rm -rf /tmp/testdata
echo 'Unzip test pack'
tar xzf testpack.tgz -C /tmp/
if  [[ $OSTYPE =~ darwin* ]]; then
	echo 'get darwin library'
	curl https://storage.googleapis.com/tensorflow/libtensorflow/libtensorflow-cpu-darwin-x86_64-1.1.0.tar.gz -o /tmp/testdata/darwin.lib.tgz
	mkdir /tmp/testdata/darwin
	echo 'expand darwin library'
	tar xzf /tmp/testdata/darwin.lib.tgz -C /tmp/testdata/darwin
else
	echo 'get linux library'
	curl https://storage.googleapis.com/tensorflow/libtensorflow/libtensorflow-cpu-linux-x86_64-1.1.0.tar.gz -o /tmp/testdata/linux.lib.tgz
	mkdir /tmp/testdata/linux
	echo 'expand linux library'
	tar xzf /tmp/testdata/linux.lib.tgz -C /tmp/testdata/linux
fi
echo 'download AI model'
curl https://storage.googleapis.com/download.tensorflow.org/models/inception5h.zip -o /tmp/testdata/in.zip
echo 'unzip model file'
unzip /tmp/testdata/in.zip -d /tmp/testdata/
echo 'testing ... '
swift test > test-results.txt
# swift test
# rm -rf /tmp/testdata
