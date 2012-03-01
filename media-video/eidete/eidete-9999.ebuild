# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit fdo-mime cmake-utils bzr

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
	|| (
		dev-lang/vala:0.16
		dev-lang/vala:0.14
	)"

src_configure() {
	local mycmakeargs=(
		-DVALA_EXECUTABLE=$(type -p valac-0.16 valac-0.14 | head -n1)
	)

	cmake-utils_src_configure
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}

