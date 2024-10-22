# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2 meson vala

DESCRIPTION="Elementary OS music player"
HOMEPAGE="https://github.com/elementary/music"
SRC_URI="https://github.com/elementary/music/archive/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/music-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	$(vala_depend)
	virtual/pkgconfig
"

RDEPEND="${DEPEND}
	dev-libs/glib:2
	dev-libs/granite:7
	gui-libs/libadwaita:1
	media-libs/gst-plugins-base:1.0
	media-libs/gstreamer:1.0
	media-plugins/gst-plugins-meta:1.0[mp3]
	gui-libs/gtk:4
"

src_prepare() {
	eapply_user
	vala_setup
}
