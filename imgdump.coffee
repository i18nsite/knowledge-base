#!/usr/bin/env coffee

> @3-/walk
  @3-/read
  @3-/write
  @3-/retry
  @3-/is-change:IsChange
  @3-/pool > Pool
  path > join
  sharp

CDN = 'fcdoc.github.io/img'

PREFIX = "https://#{CDN}/"

ROOT = import.meta.dirname
MD =  join ROOT, 'flashduty'
IMG = join ROOT, 'img'
RE_MDIMG = /src="([^"]+)"|!\[[^\]]*?\]\(([^)]+)\)/g

downImg = retry (outdir, url, li) =>
  console.log url
  response = await fetch url, {redirect: 'follow'}
  buffer = new Uint8Array await response.arrayBuffer()
  hash = new Uint8Array(await crypto.subtle.digest('SHA-256', buffer))
  hash = Buffer.from(hash).toString('base64url')
  filename = "#{hash}.avif"
  await sharp(buffer)
    .avif({ quality: 90 })
    .toFile(join outdir, filename)

  li.push [url, filename]
  return

pool = Pool 10

mdImgLi = (md) =>
  li = []

  for match from md.matchAll(RE_MDIMG)
    url = match[1] or match[2]
    if url.startsWith PREFIX
      continue
    file = url.split('/').pop()
    if file.includes('.')
      if not ['png','jpg','jpeg'].includes(url.split('.').pop().toLowerCase())
        continue
    for i from ['https://', '//', 'http://']
      if url.startsWith(i)
        if i.startsWith('//')
          url = 'https:' + url
        await pool downImg, IMG, url, li
        break
  await pool.done
  if li.length
    for [url, avif] from li
      console.log 'replaceAll', url
      md = md.replaceAll url, PREFIX + avif
    return md
  return

[
  isChange
  save
] = IsChange(
  join ROOT,'.img'
  MD
)

dump = (path) =>
  rpath = path.slice(MD.length+1)
  r = await isChange(rpath)
  if not r
    return
  md = read path
  dumped = await mdImgLi md
  if dumped
    write path, dumped
  return rpath

changed = []
for await path from walk MD, (i)=>i.startsWith('.')
  if path.endsWith('.md')
    rpath = await dump path
    if rpath
      changed.push rpath

if changed.length
  console.log 'changed',changed.length
  await save changed

process.exit 0
