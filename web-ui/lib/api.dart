const baseUrl = 'https://api.ssoda.io';

const s3Url = 'https://image.ssoda.io/';

const instagramPostUrlPrefix = 'https://www.instagram.com/p/';
const naverBlogPostUrlPrefix = 'https://blog.naver.com/';
const mobileNaverBlogPostUrlPrefix = 'https://m.blog.naver.com/';

enum API {
  GET_EVENT,
  GET_REWARD,
  GET_STORE,
  GET_EVENTS_OF_STORE,
  GET_REWARD_OF_EVENT,
  JOIN_EVENT_COMPLETE,
  PUSH_NOTIFICATION
}

Map<API, String> apiMap = {
  API.GET_EVENT: '/api/v1/events',
  API.GET_REWARD: '/api/v1/join/events',
  API.GET_STORE: '/api/v1/stores',
  API.GET_EVENTS_OF_STORE: '/api/v1/stores',
  API.GET_REWARD_OF_EVENT: '/api/v1/events',
  API.JOIN_EVENT_COMPLETE: '/api/v1/join/posts',
  API.PUSH_NOTIFICATION: '/api/v1/push/stores'
};

String getApi(API apiType, {String? suffix}) {
  String api = baseUrl;
  api += apiMap[apiType]!;
  if (suffix != null) api += '$suffix';
  return api;
}
