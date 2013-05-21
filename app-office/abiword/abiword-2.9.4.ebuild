# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/abiword/abiword-2.8.6-r2.ebuild,v 1.11 2012/08/05 21:44:50 blueness Exp $

EAPI="4"
GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"

inherit alternatives eutils gnome2 versionator autotools

MY_MAJORV=$(get_version_component_range 1-2)

DESCRIPTION="Fully featured yet light and fast cross platform word processor"
HOMEPAGE="http://www.abisource.com/"
SRC_URI="http://www.abisource.com/downloads/${PN}/${PV}/source/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="alpha amd64 ~arm ia64 ~mips ppc ppc64 sparc x86 ~amd64-linux ~x86-linux"
IUSE="collab cups gnome grammar latex math ots openxml +plugins readline spell wordperfect wmf thesaurus" # svg

# You need 'plugins' enabled if want to enable the extra plugins
REQUIRED_USE="!plugins? ( !collab !grammar !latex !math !openxml !ots !readline !thesaurus !wordperfect !wmf )"

# libgsf raised to make sure it provides gio backend
# not enabling telepathy backend for collab, it depends on libempathy-gtk which
# has be removed from empathy-2.30 already
RDEPEND="
	>=app-text/wv-1.2
	>=dev-libs/fribidi-0.10.4
	>=dev-libs/glib-2.16:2
	>=gnome-base/librsvg-2.16:2
	>=gnome-extra/libgsf-1.14.15
	>=media-libs/libpng-1.2
	virtual/jpeg
	>=x11-libs/cairo-1.8[X]
	>=x11-libs/gtk+-2.14:2[cups?]
	gnome? ( >=x11-libs/goffice-0.8:0.8 )
	plugins? (
		collab? (
			>=dev-libs/boost-1.33.1
			>=dev-libs/libxml2-2.4
			>=net-libs/loudmouth-1
			net-libs/libsoup:2.4
			net-libs/gnutls )
		grammar? ( >=dev-libs/link-grammar-4.2.1 )
		latex? ( dev-libs/libxslt )
		math? ( >=x11-libs/gtkmathview-0.7.5 )
		openxml? ( dev-libs/boost )
		ots? ( >=app-text/ots-0.5 )
		readline? ( sys-libs/readline )
		thesaurus? ( >=app-text/aiksaurus-1.2[gtk] )
		wordperfect? (
			app-text/libwpd:0.9
			app-text/libwpg:0.2 )
		wmf? ( >=media-libs/libwmf-0.2.8 )
	)
	spell? ( >=app-text/enchant-1.2 )
	!<app-office/abiword-plugins-2.8"
#		svg? ( >=gnome-base/librsvg-2 )

DEPEND="${RDEPEND}
	virtual/pkgconfig
	collab? ( dev-cpp/asio )"

pkg_setup() {
	# do not enable gnome-vfs
	G2CONF="${G2CONF}
		--enable-shave
		--disable-static
		--disable-default-plugins
		--disable-builtin-plugins
		--disable-collab-backend-telepathy
		--enable-clipart
		--enable-statusbar
		--enable-templates
		--with-gio
		--without-gnomevfs
		$(use_with gnome goffice)
		$(use_enable cups print)
		$(use_enable collab collab-backend-xmpp)
		$(use_enable collab collab-backend-tcp)
		$(use_enable collab collab-backend-service)
		$(use_enable spell)"
}

src_prepare() {
	# install icon to pixmaps (bug #220097)
	sed 's:$(datadir)/icons:$(datadir)/pixmaps:' \
		-i Makefile.am Makefile.in || die "sed 1 failed"
	# readme.txt will be installed using dodoc
	sed '/readme\.txt\|abw/d' \
		-i user/wp/Makefile.am user/wp/Makefile.in || die "sed 2 failed"

	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	local plugins=""

	if use plugins; then
		# Plugins depending on libgsf
		plugins="t602 docbook clarisworks wml kword hancom openwriter pdf
			loadbindings mswrite garble pdb applix opendocument sdw xslfo"

		# Plugins not depending on anything
		plugins="${plugins} gimp bmp freetranslation iscii s5 babelfish opml eml
			wikipedia gdict passepartout google presentation urldict hrtext mif"

		# inter7eps: eps.h
		# libtidy: gsf + tidy.h
		# paint: windows only ?
		use collab && plugins="${plugins} collab"
		use gnome && plugins="${plugins} goffice"
		use latex && plugins="${plugins} latex"
		use math && plugins="${plugins} mathview"
		use openxml && plugins="${plugins} openxml"
		use ots && plugins="${plugins} ots"
		# psion: >=psiconv-0.9.4
		use readline && plugins="${plugins} command"
		# plugin doesn't build
		#use svg && plugins="${plugins} rsvg"
		use thesaurus && plugins="${plugins} aiksaurus"
		use wmf && plugins="${plugins} wmf"
		# wordperfect: >=wpd-0.9 >=wpg-0.2
		use wordperfect && plugins="${plugins} wpg"
	fi

	gnome2_src_configure --enable-plugins="$(echo ${plugins})"
}

src_install() {
	gnome2_src_install

	sed "s:Exec=abiword:Exec=abiword-${MY_MAJORV}:" \
		-i "${ED}"/usr/share/applications/abiword.desktop || die "sed 3 failed"

	mv "${ED}/usr/bin/abiword" "${ED}/usr/bin/AbiWord-${MY_MAJORV}"
	dosym AbiWord-${MY_MAJORV} /usr/bin/abiword-${MY_MAJORV}

	dodoc AUTHORS user/wp/readme.txt
}

pkg_postinst() {
	gnome2_pkg_postinst
	alternatives_auto_makesym "/usr/bin/abiword" "/usr/bin/abiword-[0-9].[0-9]"
}

pkg_postrm() {
	gnome2_pkg_postrm
	alternatives_auto_makesym "/usr/bin/abiword" "/usr/bin/abiword-[0-9].[0-9]"
}
