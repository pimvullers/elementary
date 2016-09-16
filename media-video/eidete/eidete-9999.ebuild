# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

VALA_MIN_API_VERSION=0.20

inherit fdo-mime vala cmake-utils bzr

DESCRIPTION="Simple screencasting app for the elementary project"
HOMEPAGE="https://launchpad.net/eidete"
EBZR_REPO_URI="lp:eidete"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	media-libs/gstreamer
	media-libs/gst-plugins-base
    x11-libs/gtk+:3
	x11-libs/granite
	x11-libs/libwnck:3
	x11-libs/libXtst"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig"

src_prepare() {
	cmake-utils_src_prepare
	vala_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DVALA_EXECUTABLE="${VALAC}"
	)

	cmake-utils_src_configure
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}

