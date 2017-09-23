# SYNQ-Ruby

This is the Ruby SDK for SYNQ API.


# Installing

Add SYNQ to your Gemfile with:

```ruby
gem 'synq', github: 'SYNQfm/SYNQ-Ruby'
```


## Usage (API)

First of all, you need to set up the `SYNQ_API_KEY` environment variable with
your personal API key.

```bash
export SYNQ_API_KEY='<your_personal_api_key>'
```

### Create

Create a new video, optionally setting some metadata fields. You may optionally
set some of the metadata associated with the video. Only fields inside the
"userdata" field can be set.

```ruby
# Creating a video:
video = Synq::Api.create

# or, creating a video with metadata:
video = Synq::Api.create('{"title":  "Hello SYNQ!"}')

# Getting its attributes:
video.video_id
video.state
video.created_at
video.updated_at
video.userdata

```

Notice: In order you upload the video's file, see the [Upload](#Upload) section. 


### Query

Find videos matching any criteria, by running a JavaScript function over each
video object. A detailed tutorial on how to use this functionality is available
on the documentation page.

```ruby
# Getting all the videos:
videos = Synq::Api.query 'return video'

# Getting only the ids:
videos = Synq::Api.query 'return video.video_id'

# Finding videos based on userdata:
videos = Synq::Api.query 'if (video.userdata.category == "personal") { return video }'

# Finding the videos which their state is 'uploading'.
videos = Synq::Api.query 'if (video.sate == "uploading") { return video }'
```


### Details

Return details about a video.

```ruby
video = Synq::Api.details '<video_id>'
```


### Update

Update a video's metadata through JavaScript code. Only fields inside the
"userdata" object can be set.

```ruby
video = Synq::Api.update '<video_id>', 'video.userdata.title = "Hello world!"'
```


### Upload

Return parameters needed for uploading a video file to Amazon Simple Storage
Service. See http://docs.aws.amazon.com/AmazonS3/latest/API/sigv4-post-example.html as well
as the language-specific code-examples.

```ruby
response = Synq::Api.upload '<video_id>'
```
Example response:

```ruby
{:acl=>"public-read", :key=>"projects/a1/2b/a12b3ef4cdf74efa9f0c9f4fbdf1ced2/uploads/videos/cf/c5/cfc58fc783a34a5cb80a23456de50ad1.mp4", :Policy=>"eyJjb25kaXRpb25zIjogW3siYnVja2V0IjogInN5bnFmbSJ9LCB7ImFjbCI6ICJwdWJsaWMtcmVhZCJ9LCB7ImtleSI6ICJwcm9qZWN0cy9hMS8yYi9hMTJiM2VmNGNkZjc0ZWZhOWYwYzlmNGZiZGYxY2VkMi91cGxvYWRzL3ZpZGVvcy9jZi9jNS9jZmM1OGZjNzgzYTM0YTVjYjgwYTIzNDU2ZGU1MGFkMS5tcDQifSwgeyJDb250ZW50LVR5cGUiOiAidmlkZW8vbXA0In0sIFsiY29udGVudC1sZW5ndGgtcmFuZ2UiLCAwLCAxMDk5NTExNjI3Nzc2XV0sICJleHBpcmF0aW9uIjogIjIwMTctMDktMjRUMjE6NDY6MjIuNDAwWiJ9", :action=>"https://synqfm.s3.amazonaws.com", :Signature=>"kln7Wwv6yrprTMvl0q7w3P0X2dk=", :"Content-Type"=>"video/mp4", :AWSAccessKeyId=>"AKIAIP77Y7MMX3ITZMFA"}
```

To upload the file, you can then make a multipart POST request to the URL in
`action`, and for all the other parameters returned, set them as form parameters.

Given the parameters above, you would upload a file `test.mp4` using cURL like this:

```bash
curl -s https://synqfm.s3.amazonaws.com/ \
  -F AWSAccessKeyId="AKIAIP77Y7MMX3ITZMFA" \
  -F Content-Type="video/mp4" \
  -F Policy="eyJjb25kaXRpb25zIjogW3siYnVja2V0IjogInN5bnFmbSJ9LCB7ImFjbCI6ICJwdWJsaWMtcmVhZCJ9LCB7ImtleSI6ICJwcm9qZWN0cy9hMS8yYi9hMTJiM2VmNGNkZjc0ZWZhOWYwYzlmNGZiZGYxY2VkMi91cGxvYWRzL3ZpZGVvcy9jZi9jNS9jZmM1OGZjNzgzYTM0YTVjYjgwYTIzNDU2ZGU1MGFkMS5tcDQifSwgeyJDb250ZW50LVR5cGUiOiAidmlkZW8vbXA0In0sIFsiY29udGVudC1sZW5ndGgtcmFuZ2UiLCAwLCAxMDk5NTExNjI3Nzc2XV0sICJleHBpcmF0aW9uIjogIjIwMTctMDktMjRUMjE6NDY6MjIuNDAwWiJ9" \
  -F Signature="kln7Wwv6yrprTMvl0q7w3P0X2dk=" \
  -F acl="public-read" \
  -F key="projects/a1/2b/a12b3ef4cdf74efa9f0c9f4fbdf1ced2/uploads/videos/cf/c5/cfc58fc783a34a5cb80a23456de50ad1.mp4" \
  -F file="@test.mp4"
```

For while, this gem doesn't upload files.


### Uploader

Returns an embeddable url, that contains an uploader widget that allows you to
easily upload any mp4. Great way to simplify the uploading process for end
users.

```ruby
response = Synq::Api.uploader '<video_id>'
response.uploader_url
```
