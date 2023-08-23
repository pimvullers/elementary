# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2 meson vala

DESCRIPTION="Elementary OS music player"
HOMEPAGE="https://github.com/elementary/music"
SRC_URI="https://github.com/elementary/music/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
	>=dev-lang/vala-0.40
	virtual/pkgconfig
"

RDEPEND="${DEPEND}
	>=dev-libs/glib-2.39:2
	dev-libs/granite:7
	media-libs/gst-plugins-base
	media-libs/gstreamer
	media-plugins/gst-plugins-meta[mp3]
	gui-libs/gtk:4
"

S="${WORKDIR}/music-${PV}"

src_prepare() {
	eapply_user
	vala_setup
}
