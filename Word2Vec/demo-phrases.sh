#!/usr/bin/env bash
#make
#if [ ! -e news.2012.en.shuffled ]; then
#  wget http://www.statmt.org/wmt14/training-monolingual-news-crawl/news.2012.en.shuffled.gz
#  gzip -d news.2012.en.shuffled.gz -f
#fi
echo "Start"
sed -e "s/’/'/g" -e "s/′/'/g" -e "s/''/ /g" < /Users/anirudhprabhu/PycharmProjects/HECK/Word2Vec/DCO_publications.txt | tr -c "A-Za-z'_ \n" " " > books_large_p2-norm0
echo "Step 1"
time ./word2phrase -train books_large_p2-norm0 -output books_large_p2-norm0-phrase0 -threshold 200 -debug 2
echo "Step 2"
time ./word2phrase -train books_large_p2-norm0-phrase0 -output books_large_p2-norm0-phrase1 -threshold 100 -debug 2
echo "Step 3"
tr A-Z a-z < books_large_p2-norm0-phrase1 > books_large_p2-norm1-phrase1
time ./word2vec -train books_large_p2-norm1-phrase1 -output vectors-phrase.bin -cbow 1 -size 200 -window 10 -negative 25 -hs 0 -sample 1e-5 -threads 20 -binary 1 -iter 15
echo "Step 4"
#./distance vectors-phrase.bin
