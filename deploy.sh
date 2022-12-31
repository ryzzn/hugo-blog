#!/bin/bash

hugo --environment=production

ossutil cp -r public oss://ryzn-me/ -u
