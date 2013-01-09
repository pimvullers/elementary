# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit fdo-mime gnome2-utils cmake-utils bzr

DESCRIPTION="A simple, modern media player"
HOMEPAGE="https://launchpad.net/audience"
EBZR_REPO_URI="lp:audience"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	media-libs/clutter-gst:1.0
	media-libs/clutter-gtk:1.0
	media-libs/gstreamer:0.10
	media-libs/gst-plugins-base:0.10
	x11-libs/granite
	x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	dev-lang/vala:0.18
	dev-util/pkgconfig"

src_configure() {
	local mycmakeargs=(
	    -DGSETTINGS_COMPILE=OFF
		-DVALA_EXECUTABLE="$(type -p valac-0.18)"
	)

	cmake-utils_src_configure
}

pkg_preinst() {
	gnome2_icon_savelist
	gnome2_schemas_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
	gnome2_schemas_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
	gnome2_schemas_update
}

