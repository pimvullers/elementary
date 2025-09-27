# Copyright 2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2 meson vala

DESCRIPTION="Photo viewer and organizer designed for elementary OS"
HOMEPAGE="https://github.com/elementary/photos/"
SRC_URI="https://github.com/elementary/photos/archive/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/photos-${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="plugins doc"

DEPEND="
	$(vala_depend)
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig
"

RDEPEND="${DEPEND}
	dev-db/sqlite:3
	dev-libs/glib:2
	<dev-libs/granite-7:0
	dev-libs/libgudev
	dev-libs/libgee:0.8
	gui-libs/libhandy:1
	dev-libs/libportal[gtk]
	media-libs/gexiv2
	media-libs/gstreamer:1.0
	media-libs/gst-plugins-base:1.0
	media-libs/libexif
	media-libs/libgphoto2
	media-libs/libraw
	media-libs/libwebp
	sci-geosciences/geocode-glib:2
	x11-libs/gtk+:3
"

src_prepare() {
	eapply_user
	vala_setup
}

src_configure() {
	local emesonargs=(
		-Dplugins=$(usex plugins true false)
		-Ddocumentation=$(usex doc true false)
	)
	meson_src_configure
}
