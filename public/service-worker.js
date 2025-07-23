self.addEventListener('install', () => {
  console.log('bsign App installed')
})

self.addEventListener('activate', () => {
  console.log('bsign App activated')
})

self.addEventListener('fetch', (event) => {
  event.respondWith(fetch(event.request))
})
